import httpx


def response_log(data: httpx.Response):
    print('response data type: ', type(data))
    request = data.request
    print(f"Response event hook: {request.method} {request.url} - Status {data.status_code} content {data.json()}")
