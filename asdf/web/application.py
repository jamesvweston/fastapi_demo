from fastapi import FastAPI
from fastapi.responses import UJSONResponse
import logging
from asdf.web.api.router import api_router
from asdf.settings import settings
from asdf.web.gql.router import gql_router
from asdf.web.lifetime import register_startup_event, register_shutdown_event
from importlib import metadata
from fastapi.staticfiles import StaticFiles
from pathlib import Path


APP_ROOT = Path(__file__).parent.parent


def get_app() -> FastAPI:
    """
    Get FastAPI application.

    This is the main constructor of an application.

    :return: application.
    """
    app = FastAPI(
        title="asdf",
        description="asdf",
        version=metadata.version("asdf"),
        docs_url=None,
        redoc_url=None,
        
        openapi_url="/api/openapi.json",
        default_response_class=UJSONResponse,
    )

    # Adds startup and shutdown events.
    register_startup_event(app)
    register_shutdown_event(app)

    # Main router for the API.
    app.include_router(router=api_router, prefix="/api")
    # Graphql router
    app.include_router(router=gql_router, prefix="/graphql")
    # Adds static directory.
    # This directory is used to access swagger files.
    app.mount(
        "/static",
        StaticFiles(directory=APP_ROOT / "static"),
        name="static"
    )
    

    return app
