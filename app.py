import asyncio
import json
import threading
from concurrent.futures import ThreadPoolExecutor

from flask import Flask, request, render_template, jsonify
from flask_socketio import SocketIO

import config
import db
from cache.cache_factory import CacheFactory
from cmd_arg import Args
from main import CrawlerFactory
from tools.time_util import get_current_time
from tools.utils import logger

app = Flask(__name__)
# app.config['SECRET_KEY'] = 'your_secret_key'  # 添加一个密钥
socketio = SocketIO(app, async_mode='threading')  # 使用 threading 模式
cache = CacheFactory.create_cache("memory")
executor = ThreadPoolExecutor()


@app.route("/")
def hello():
    return render_template("index.html")


@app.post("/run")
def run():
    try:
        cmd = request.data
        args = json.loads(cmd)
        logger.info(f'received request: {args}')
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
                    logger.info(f"task {old_task} exists.")

        if task is None:
            # Start the task in a background thread
            executor.submit(start_task, arg, task_name)
            return jsonify({"message": f"Task {task_name} started successfully"}), 202
        else:
            return jsonify({"message": f"Task {task_name} is already running"}), 200
    except Exception as e:
        error = str(e)
        logger.error(f"Error in run(): {error}")
        return jsonify({"error": error}), 400


def start_task(arg, task_name):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.run_until_complete(_start_task(arg, task_name))
    loop.close()


async def _start_task(arg, task_name):
    try:
        if config.SAVE_DATA_OPTION == "sqlite":
            await db.init_sqlite_db()

        cache.set(task_name, get_current_time(), expire_time=2 * 24 * 60 * 60)
        cache.set(arg.platform, True, expire_time=2 * 24 * 60 * 60)

        crawler = CrawlerFactory.create_crawler(platform=config.PLATFORM)
        # perform_search(json.dumps(arg))
        await crawler.start()

        logger.info(f"Task {task_name} completed successfully")
    except Exception as e:
        logger.error(f"Error in _start_task: {str(e)}")
    finally:
        callback(arg)


def callback(arg: Args):
    logger.info("task done.")
    socketio.emit('searchStatus', {'message': '搜索完成'})
    task_name = f"{arg.platform}-{arg.keywords}-task"
    result = {
        'id': 1,
        'name': task_name,
        'platform': arg.platform,
        'keywords': arg.keywords,
        'start': cache.get(task_name),
        'end': get_current_time()
    }
    socketio.emit('searchResult', {'type': 'searchResult', 'results': [result]})


def perform_search(data):
    data = json.loads(data)
    # 模拟搜索过程
    socketio.emit('searchStatus', {'message': '开始搜索...'})
    result = {
        'id': 1,
        'name': f'{data["platform"]}-{data["keywords"]}-task',
        'platform': f'{data["platform"]}',
        'keywords': f'{data["keywords"]}',
        'start': get_current_time(),
        'end': ''
    }
    socketio.emit('searchResult', {'type': 'searchResult', 'results': [result]})
    #     socketio.emit('searchStatus', {'message': f'已找到 {i + 1} 个结果'})

    # socketio.emit('searchStatus', {'message': '搜索完成'})


@socketio.on('search')
def handle_search(data):
    print('Received search request:', data)
    # 在新线程中执行搜索,以避免阻塞
    threading.Thread(target=perform_search, args={data}).start()


if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0", port=5000, debug=True)
