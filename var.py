import asyncio
from asyncio.tasks import Task
from contextvars import ContextVar
from functools import wraps
from typing import List

import aiomysql
from flask_socketio import SocketIO

from async_db import AbstractDBClient

request_keyword_var: ContextVar[str] = ContextVar("request_keyword", default="")
crawler_type_var: ContextVar[str] = ContextVar("crawler_type", default="")
comment_tasks_var: ContextVar[List[Task]] = ContextVar("comment_tasks", default=[])
media_crawler_db_var: ContextVar[AbstractDBClient] = ContextVar("media_crawler_db_var")
db_conn_pool_var: ContextVar[aiomysql.Pool] = ContextVar("db_conn_pool_var")
source_keyword_var: ContextVar[str] = ContextVar("source_keyword", default="")
socketio_var: ContextVar[SocketIO] = ContextVar("socketio")


def ensure_context(func):
    @wraps(func)
    async def wrapper(*args, **kwargs):
        socketio = get_socketio()
        if socketio is None:
            raise RuntimeError("SocketIO not initialized")

        # 创建一个新的上下文，并在其中运行函数
        ctx = asyncio.create_task(asyncio.to_thread(func, *args, **kwargs))
        return await ctx

    return wrapper


def get_socketio():
    return socketio_var.get()


def set_socketio(socketio):
    socketio_var.set(socketio)
