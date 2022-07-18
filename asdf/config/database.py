from dataclasses import dataclass
from os import environ

from yarl import URL


@dataclass(frozen=True)
class PostgresConfig:
    scheme: str
    host: str
    port: int
    user: str
    password: str
    base: str
    echo: bool = False

    @property
    def url(self) -> URL:
        """
        Assemble database URL from settings.

        :return: database URL.
        """
        return URL.build(
            scheme=self.scheme,
            host=self.host,
            port=self.port,
            user=self.user,
            password=self.password,
            path=f"/{self.base}",
        )


@dataclass(frozen=True)
class DatabaseSettings:
    default: PostgresConfig = PostgresConfig(
        scheme="postgresql+asyncpg",
        host=environ.get("DB_HOST"),
        port=int(environ.get("DB_PORT", 5432)),
        user=environ.get("DB_USER"),
        password=environ.get("DB_PASSWORD"),
        base=environ.get("DB_BASE"),
    )
