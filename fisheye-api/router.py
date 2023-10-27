
from fastapi import APIRouter, Depends, Request, HTTPException
from fastapi.responses import JSONResponse
router = APIRouter()

@router.get("/")
async def info(request: Request):
    return "Hey there, Sonny!"