# Standard library
from json import dumps
from re import VERBOSE as re_VERBOSE
from re import compile as re_compile
from re import sub as re_sub

SKIP_HEADERS = re_compile(
    r"""
    ^gunicorn
    |^path
    |^query
    |^raw
    |^remote
    |^request
    |^script
    |^server
    |^wsgi
    """,
    re_VERBOSE,
)


def app(env, start_response):
    # body
    data = {}
    for key, value in env.items():
        name = key.lower()
        if SKIP_HEADERS.match(name):
            continue
        name = name.title().replace("_", "-").removeprefix("Http-")
        name = re_sub("^Cf-", "CF-", name)
        name = re_sub("-Id$", "-ID", name)
        name = re_sub("-Ip$", "-IP", name)
        data[name] = value
    body = dumps(data, sort_keys=True).encode()
    # response
    headers = [
        ("Cache-Control", "no-store, no-transform, max-age=0"),
        ("Content-Length", str(len(body))),
        ("Content-Type", "application/json"),
    ]
    start_response("200 OK", headers)
    return [body]
