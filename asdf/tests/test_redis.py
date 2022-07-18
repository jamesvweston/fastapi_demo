import uuid

import pytest
from fakeredis.aioredis import FakeRedis
from fastapi import FastAPI
from httpx import AsyncClient
from starlette import status


@pytest.mark.anyio
async def test_setting_value(
    fastapi_app: FastAPI,
    fake_redis: FakeRedis,
    client: AsyncClient,
) -> None:
    """
    Tests that you can set value in redis.

    :param fastapi_app: current application fixture.
    :param fake_redis: fake redis instance.
    :param client: client fixture.
    """
    url = fastapi_app.url_path_for("handle_http_post")

    test_key = uuid.uuid4().hex
    test_val = uuid.uuid4().hex
    query = """
    mutation ($key: String!, $val: String!) {
        setRedisValue(data: { key: $key, value: $val }) {
            key
            value
        }
    }
    """
    response = await client.post(
        url,
        json={
            "query": query,
            "variables": {"key": test_key, "val": test_val},
        },
    )

    assert response.status_code == status.HTTP_200_OK
    actual_value = await fake_redis.get(test_key)
    assert actual_value == test_val


@pytest.mark.anyio
async def test_getting_value(
    fastapi_app: FastAPI,
    fake_redis: FakeRedis,
    client: AsyncClient,
) -> None:
    """
    Tests that you can get value from redis by key.

    :param fastapi_app: current application fixture.
    :param fake_redis: fake redis instance.
    :param client: client fixture.
    """
    test_key = uuid.uuid4().hex
    test_val = uuid.uuid4().hex
    await fake_redis.set(test_key, test_val)
    url = fastapi_app.url_path_for("handle_http_post")
    response = await client.post(
        url,
        json={
            "query": "query($key:String!){redis:getRedisValue(key:$key){key value}}",
            "variables": {
                "key": test_key,
            },
        },
    )

    assert response.status_code == status.HTTP_200_OK
    assert response.json()["data"]["redis"]["key"] == test_key
    assert response.json()["data"]["redis"]["value"] == test_val
