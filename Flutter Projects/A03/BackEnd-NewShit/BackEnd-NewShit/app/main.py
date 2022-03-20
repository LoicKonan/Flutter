from fastapi import FastAPI, Depends
from fastapi.security import OAuth2PasswordBearer
from app.api.file_router.file_upload import file_upload
from app.api.authentication.authenticate import authenticate


import uvicorn

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl='token')

app.include_router(file_upload)
app.include_router(authenticate)

if __name__ == '__main__':
    uvicorn.run('main:app', host='0.0.0.0', port=8000, reload=True)
