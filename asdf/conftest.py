import asyncio
from asyncio.events import AbstractEventLoop
import sys
from typing import Any, Generator, AsyncGenerator

import pytest
from fastapi import FastAPI
from httpx import AsyncClient
import uuid
from unittest.mock import Mock
from fakeredis.aioredis import FakeRedis
from asdf.services.redis.dependency import get_redis_connection
from asdf.settings import settings
from asdf.web.application import get_app
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, AsyncEngine, AsyncConnection
from sqlalchemy.orm import sessionmaker
from asdf.db.dependencies import get_db_session
from asdf.db.utils import create_database, drop_database


@pytest.fixture(scope="session")
def anyio_backend() -> str:
    """
    Backend for anyio pytest plugin.

    :return: backend name.
    """
    return 'asyncio'
@pytest.fixture(scope="session")
async def _engine() -> AsyncGenerator[AsyncEngine, None]:
    """
    Create engine and databases.

    :yield: new engine.
    """
    from asdf.db.meta import meta  # noqa: WPS433
    from asdf.db.models import load_all_models  # noqa: WPS433

    load_all_models()

    await create_database()

    engine = create_async_engine(str(settings.db_url))
    async with engine.begin() as conn:
        await conn.run_sync(meta.create_all)

    try:
        yield engine
    finally:
        await engine.dispose()
        await drop_database()

@pytest.fixture
async def dbsession(
    _engine: AsyncEngine,
) -> AsyncGenerator[AsyncSession, None]:
    """
    Get session to database.

    Fixture that returns a SQLAlchemy session with a SAVEPOINT, and the rollback to it
    after the test completes.

    :param _engine: current engine.
    :yields: async session.
    """
    connection = await _engine.connect()
    trans = await connection.begin()

    session_maker = sessionmaker(
        connection, expire_on_commit=False, class_=AsyncSession,
    )
    session = session_maker()

    try:
        yield session
    finally:
        await session.close()
        await trans.rollback()
        await connection.close()

@pytest.fixture
async def fake_redis() -> AsyncGenerator[FakeRedis, None]:
    """
    Get instance of a fake redis.

    :yield: FakeRedis instance.
    """
    redis = FakeRedis(decode_responses=True)
    yield redis
    await redis.close()

@pytest.fixture
def fastapi_app(
    dbsession: AsyncSession,
    fake_redis: FakeRedis,
) -> FastAPI:
    """
    Fixture for creating FastAPI app.

    :return: fastapi app with mocked dependencies.
    """
    application = get_app()
    application.dependency_overrides[get_db_session] = lambda: dbsession
    application.dependency_overrides[get_redis_connection] = lambda: fake_redis
    return application  # noqa: WPS331


@pytest.fixture
async def client(
    fastapi_app: FastAPI,
    anyio_backend: Any
) -> AsyncGenerator[AsyncClient, None]:
    """
    Fixture that creates client for requesting server.

    :param fastapi_app: the application.
    :yield: client for the app.
    """
    async with AsyncClient(app=fastapi_app, base_url="http://test") as ac:
            yield ac
