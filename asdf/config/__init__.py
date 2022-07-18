"""config settings."""
from dataclasses import dataclass
from pathlib import Path
from tempfile import gettempdir

from asdf.config.app import AppSettings
from asdf.config.cache import CacheSettings
from asdf.config.database import DatabaseSettings

TEMP_DIR = Path(gettempdir())


@dataclass(frozen=True)
class Config:
    app: AppSettings = AppSettings()
    cache: CacheSettings = CacheSettings()
    database: DatabaseSettings = DatabaseSettings()


config = Config()
