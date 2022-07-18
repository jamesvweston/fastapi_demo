from dataclasses import dataclass
from os import environ
from typing import Optional

from yarl import URL


@dataclass(frozen=True)
class RedisConfig:
    scheme: str
    host: str
    port: int
    user: Optional[str] = None
    password: Optional[str] = None
    base: Optional[int] = None

    @property
    def url(self) -> URL:
        """
        Assemble REDIS URL from settings.

        :return: redis URL.
        """
        path = ""
        if self.base is not None:
            path = f"/{self.base}"
        return URL.build(
            scheme="redis",
            host=self.host,
            port=self.port,
            user=self.user,
            password=self.password,
            path=path,
        )


@dataclass(frozen=True)
class CacheSettings:
    default: RedisConfig = RedisConfig(
        scheme="redis",
        host=environ.get("REDIS_HOST"),
        port=int(environ.get("REDIS_PORT")),
        user=environ.get("REDIS_USER"),
        password=environ.get("REDIS_PASSWORD"),
    )
