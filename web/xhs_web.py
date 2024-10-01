import datetime
import decimal
import math
from typing import List, Dict, Any

from flask import Blueprint, request, jsonify

from tools import utils
from tools.utils import logger
from . import db
from tools import words

xhs = Blueprint('xhs', __name__, url_prefix="/xhs")


@xhs.post("/note/list")
async def list_pages():
    utils.logger.info(f"{request.url} {request.json}")
    query_json = request.json
    page = query_json.get('page', {})
    page_no = int(page.get('pageNo', 1))
    page_size = int(page.get('pageSize', 10))
    count = await get_list_cnt(query_json)
    if count > 0:
        page_data = await get_list(query_json)
        total_page = math.ceil(count / page_size)
        return jsonify({"code": 200, "message": "ok", "data": {
            "pageNo": page_no,
            "pageSize": page_size,
            "total": count,
            "totalPage": total_page,
            "list": page_data
        }}), 200

    return jsonify({"code": 200, "message": "ok", "data": {}, 'total': count}), 200


@xhs.post("/note/wordcloud")
async def world_could():
    utils.logger.info(f"{request.url} {request.json}")
    query_json = request.json
    query_words = query_json.get('q', [])
    tag_words = await get_tags_list(query_words)
    clouds = words.AsyncWordCloudGenerator()
    words_cloud_url = await clouds.generate_web_words_cloud(tag_words, f"{query_words}", top_number=50)
    return jsonify({"code": 200, "message": "ok", "data": words_cloud_url}), 200


# 获取词云
async def get_tags_list(query_words: str) -> List[str]:
    database = db.get_db()
    sql: str = f"SELECT tag_list FROM xhs_note WHERE source_keyword LIKE '%{query_words}%'"
    cur = database.execute(sql)
    rows = cur.fetchall()
    cur.close()
    result = []
    for row in rows:
        tag = row[0]
        if tag.strip() != '':
            result.append(row[0])
    return result


async def get_list_cnt(query_json):
    database = db.get_db()
    query = query_json.get('q', '')
    sql: str = f"SELECT COUNT(*) FROM xhs_note WHERE source_keyword LIKE '%{query}%'"
    cur = database.execute(sql)
    count = cur.fetchone()[0]
    cur.close()
    logger.info("total size:" + str(count))
    return int(count)


async def get_list(query_json) -> List[Dict[str, Any]]:
    database = db.get_db()
    page = query_json.get('page', {})
    page_no = int(page.get('pageNo', 1))
    page_size = int(page.get('pageSize', 10))
    offset = (page_no - 1) * page_size
    query = query_json.get('q', '')

    count = await get_list_cnt(query_json)
    if count == 0:
        return []

    sql: str = "SELECT * FROM xhs_note WHERE source_keyword LIKE ? order by liked_count, `time` desc LIMIT ?, ?"
    params = (f"%{query}%", offset, page_size)

    try:
        cur = database.execute(sql, params)
        rows = cur.fetchall()
        cur.close()

        # 将行数据转换为字典列表
        result = []
        for row in rows:
            row_dict = dict(zip([column[0] for column in cur.description], row))
            # 确保所有值都是JSON可序列化的
            for key, value in row_dict.items():
                if isinstance(value, (datetime.date, datetime.datetime)):
                    row_dict[key] = value.isoformat()
                elif isinstance(value, decimal.Decimal):
                    row_dict[key] = float(value)
            result.append(row_dict)

        return result
    except Exception as e:
        logger.error("Database error", exc_info=True)
        raise
