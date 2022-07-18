from fastapi import FastAPI
from redis.asyncio import ConnectionPool

from asdf.config import config


def init_redis(app: FastAPI) -> None:
    """
    Creates connection pool for redis.

    :param app: current fastapi application.
    """
    app.state.redis_pool = ConnectionPool.from_url(
        str(config.cache.default.url),
    )


async def shutdown_redis(app: FastAPI) -> None:
    """
    Closes redis connection pool.

    :param app: current FastAPI app.
    """
    await app.state.redis_pool.disconnect()
