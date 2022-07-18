from fastapi import Depends
from redis.asyncio import Redis
from sqlalchemy.ext.asyncio import AsyncSession
from strawberry.fastapi import BaseContext

from asdf.db.dependencies import get_db_session
from asdf.services.redis.dependency import get_redis_connection


class Context(BaseContext):
    """Global graphql context."""

    def __init__(
        self,
        redis: Redis = Depends(get_redis_connection),
        db_connection: AsyncSession = Depends(get_db_session),
    ) -> None:
        self.redis = redis
        self.db_connection = db_connection
        pass  # noqa: WPS420


def get_context(context: Context = Depends(Context)) -> Context:
    """
    Get custom context.

    :param context: graphql context.
    :return: context
    """
    return context
