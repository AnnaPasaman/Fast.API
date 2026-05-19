from fastapi import FastAPI
from app.api.v1.endpoints import users

app = FastAPI(title="My FastAPI Project")

app.include_router(users.router, prefix="/users", tags=["users"])
@app.get("/")
def root():
    return {"message": "Project is running and routers are connected!"}
@app.get("/")
async def root():
    return {"message": "Hello World Docker Reload!"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}
