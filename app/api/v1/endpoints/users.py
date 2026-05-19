from fastapi import APIRouter, HTTPException
from typing import Dict
from app.schemas.user import User, UserCreate

router = APIRouter()

# Емуляція бази даних
users_db: Dict[int, dict] = {
    1: {"id": 1, "name": "Ivan", "email": "ivan@example.com"}
}

@router.get("/", response_model=list[User])
def get_users():
    return list(users_db.values())

@router.post("/", response_model=User)
def create_user(user: UserCreate):
    new_id = len(users_db) + 1
    new_user = {"id": new_id, **user.model_dump()}
    users_db[new_id] = new_user
    return new_user

@router.put("/{user_id}", response_model=User)
def update_user(user_id: int, user: UserCreate):
    if user_id not in users_db:
        raise HTTPException(status_code=404, detail="User not found")
    users_db[user_id] = {"id": user_id, **user.model_dump()}
    return users_db[user_id]

@router.delete("/{user_id}")
def delete_user(user_id: int):
    if user_id not in users_db:
        raise HTTPException(status_code=404, detail="User not found")
    del users_db[user_id]
    return {"message": "User deleted"}