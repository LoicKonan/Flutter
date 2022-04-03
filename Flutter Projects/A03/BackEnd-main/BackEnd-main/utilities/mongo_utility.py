import json
import mimetypes
import os

import pymongo
from pymongo import MongoClient
from models.models import User, RegisterUser
import gridfs
from fastapi import HTTPException

from utilities.utility import Utility


class MongoUtility(Utility):
    def __init__(self):
        self.client = MongoClient("mongodb://localhost:27017/")
        self.db = None
        self.collection = None

    def create_new_user(self, user: User):
        self.db = self.client['users']
        self.collection = self.db['verified_users']
        self.collection.insert_one(dict(user))
        # try:
        #     assert self.collection.find({"username": user.username}) == user
        # except AssertionError as e:
        #     print(f'Insertion failed for {user.username}')

    def get_user_hash(self, username: str):
        self.db = self.client['users']
        self.collection = self.db['verified_users']
        exist_user = self.collection.find_one({"username": username})
        hash =  exist_user['hashed_password'] if exist_user else None
        return hash


    def check_existing_user(self, username):
        self.db = self.client['users']
        self.collection = self.db['verified_users']
        exist_user = self.collection.find_one(
            {"username": username},
            {"_id": 0})
        print(exist_user)
        return exist_user if exist_user else None

    def store_cpp_file_list(self, collection, student_name, file_list):
        self.db = self.client[collection]
        fs = gridfs.GridFS(self.db)

        for file in file_list:
            print(f'Putting {file.filename} in gridfs')
            fs.put(file.file, filename=file.filename, student_name=student_name)
            try:
                assert fs.exists({"filename": file.filename,
                                  "student_name": student_name})
            except AssertionError as asserter:
                return HTTPException(
                    status_code=500,
                    detail="Failed to save files to database"
                )
            return {
                "status_code" : 200,
                "details": "Successfully saved files to MONGODB",
            }


if __name__=='__main__':
    user = {
        "username": "johndoe",
        "fullname": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password":
        "$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW",
        "disabled": False
        }
    mu = MongoUtility()

    mu.check_existing_user('johndoe')
    print(mu.get_user_hash(user))
