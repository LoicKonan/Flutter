import uvicorn
from fastapi import FastAPI
from src.user import main as user_main
from mongoengine import connect, disconnect

app = FastAPI()
connect('my_db_fast_api', host='127.0.0.1', port=27107)

app.include_router(user_main.router)

if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=8005)
    print("running")