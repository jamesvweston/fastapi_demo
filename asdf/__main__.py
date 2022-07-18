import uvicorn

from asdf.config import config


def main() -> None:
    """Entrypoint of the application."""
    uvicorn.run(
        "asdf.web.application:get_app",
        workers=config.app.workers_count,
        host=config.app.host,
        port=config.app.port,
        reload=config.app.reload,
        log_level=config.app.log_level.value.lower(),
        factory=True,
    )


if __name__ == "__main__":
    main()
