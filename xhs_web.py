import json

from tools import utils
from flask import Blueprint, request, jsonify

xhs = Blueprint('xhs', __name__, url_prefix="/xhs")


@xhs.post("/note/list")
def list_pages():
    utils.logger.info(f"{request.url} {request.json}")
    return jsonify(json.loads(request.data)), 200
