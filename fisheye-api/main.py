from fastapi import FastAPI
from .router import router

def get_application():
    #_app = FastAPI(title=settings.PROJECT_NAME)
    _app = FastAPI(title="Fisheye API")

    return _app

app = get_application()
app.include_router(router)