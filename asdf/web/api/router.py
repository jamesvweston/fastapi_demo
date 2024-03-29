from fastapi.routing import APIRouter

from asdf.web.api import docs, monitoring

api_router = APIRouter()
api_router.include_router(monitoring.router)
api_router.include_router(docs.router)
