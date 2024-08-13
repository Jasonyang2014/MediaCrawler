import json
import asyncio
from flask import Flask, request
from cmd_arg import Args
from main import CrawlerFactory
import config
import db
from asgiref.wsgi import WsgiToAsgi
from cache.cache_factory import CacheFactory
from tools.utils import logger

app = Flask(__name__)
cache = CacheFactory.create_cache("memory")


@app.route("/")
def hello():
    return "Hello, World!"


@app.post("/run")
async def run():
    error = None
    try:
        cmd = request.data
        args = json.loads(cmd)
        logger.info(f'received request:{args}')
        arg = Args(**args)
        arg.parse()
        task_name = f"{arg.platform}-{arg.keywords}-task"
        platform_exists = cache.get(arg.platform)
        task = cache.get(task_name)
        if platform_exists:
            logger.info(f"platform {arg.platform} is running.")
            task_list = cache.keys(f"{arg.platform}-")
            if task_list:
                logger.info(f"stopping task {task_list[0]}")
                old_task = cache.get(task_list[0])
                if old_task and not old_task.done():
                    old_task.cancel()
                    logger.info(f"stopped task {old_task}")

        if task is None or task.done():
            loop = asyncio.get_running_loop()
            task = loop.create_task(start())
            cache.set(task_name, task, expire_time=2 * 24 * 60 * 60)
            cache.set(arg.platform, True, expire_time=2 * 24 * 60 * 60)
            return f"Task {task_name} started successfully", 202
        else:
            return f"Task {task_name} is already running", 200
    except Exception as e:
        error = str(e)
        print(error)
        return f"Error: {error}", 400


async def start():
    if config.SAVE_DATA_OPTION == "db":
        await db.init_db()

    crawler = CrawlerFactory.create_crawler(platform=config.PLATFORM)
    await crawler.start()

    if config.SAVE_DATA_OPTION == "db":
        await db.close()


# 将 Flask 应用转换为 ASGI 应用
asgi_app = WsgiToAsgi(app)

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(asgi_app, host="0.0.0.0", port=5000)
