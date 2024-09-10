import json

import httpx

from var import get_socketio
from var import ensure_context


@ensure_context
async def response_log(data: httpx.Response):
    print('response data type: ', type(data))
    request = data.request
    response = data
    resp = await response.aread()
    response_json = resp.decode('utf-8')
    print(f"Response event hook: {request.method} {request.url} - Status {data.status_code} content {response_json}")
    try:
        socketio = get_socketio()
        socketio.send({"data": "hello"}, namespace="/comment")
    except Exception as e:
        print(str(e.__cause__.args))
    if request.url.path.find('sns/web/v2/comment/') != -1:
        send_result(response_json)
        print('send comment')


def send_result(content: str):
    text = json.loads(content)
    data = text['data']
    if data is None:
        return
    comment = data['comments']
    print(comment)
    # if comment is not None:
    #     try:
    #         socketio = socketio_var.get()
    #         socketio.send({"data": comment[0]['content']}, namespace='/comment')
    #     except Exception as e:
    #         print(str(e.__cause__.args))
