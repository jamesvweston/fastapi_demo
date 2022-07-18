from dataclasses import dataclass
from os import environ

from asdf.config.logging import LogLevel


@dataclass(frozen=True)
class AppSettings:
    """
    Application settings.

    These parameters can be configured
    with environment variables.
    """

    host: str = environ.get("APP_HOST")
    port: int = int(environ.get("APP_PORT"))
    # quantity of workers for uvicorn
    workers_count: int = 1
    # Enable uvicorn reloading
    reload: bool = environ.get("APP_RELOAD", False)

    # Current environment
    environment: str = environ.get("APP_ENV", "dev")

    log_level: LogLevel = LogLevel.INFO
