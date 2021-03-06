from fastapi import FastAPI, Depends
from fastapi.security import OAuth2PasswordBearer
from app.api.file_router.file_upload import file_upload
from app.api.authentication.authenticate import authenticate
from fastapi.middleware.cors import CORSMiddleware
from app.api.class_api.class_api import class_upload
import uvicorn

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
oauth2_scheme = OAuth2PasswordBearer(tokenUrl='token')

app.include_router(file_upload)
app.include_router(authenticate)
app.include_router(class_upload)
if __name__ == '__main__':
    uvicorn.run('main:app', host='0.0.0.0', port=8000, reload=True)
