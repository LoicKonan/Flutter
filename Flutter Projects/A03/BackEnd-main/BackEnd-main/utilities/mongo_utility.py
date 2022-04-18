from dataclasses import replace
import json
import mimetypes
import os
from pprint import pprint
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
    def get_all_class_names(self):
        self.db = self.client['Classes']
        return self.db.list_collection_names()
    def store_class_name(self, class_name):
        self.db = self.client['Classes']
        self.collection = self.db[class_name]
        
        if not class_name in self.db.list_collection_names():
            self.collection.insert({})
        
    def store_student_results(self, class_name, student, assn_num,results):
        
        self.store_class_name(class_name)
        self.db = self.client[class_name]
        self.collection = self.db[student]
        
        
        found_user = list(self.collection.find({'student_name': student},{'_id':1}))
        print('found_user **************************************8')
        print(found_user)
        if not found_user:
            # document not found_user for user, create document, add dictionary push to db
            temp_dict = {
                'student_name': student,
                'assignments': []
            }
            self.collection.insert_one(temp_dict)
            result = self.collection.find_one({'student_name': student},{'_id':1})
            id = result['_id']
            update = self.collection.update_one({'_id':id},{'$push':{'assignments': results}})
            print(f'After push update = {update}')
        elif found_user:
            # replace existing document, id == id
            id = found_user[0]['_id']
            existing_user = self.collection.find_one({'_id': id})
            # existing_user['assignments'].append(results)
            replaced = False
            temp_list = []
            for assn in existing_user['assignments']:
                print(f"EXISTING USER Assignment: {assn['assignment']}")
                print(f"INCOMING USER ASSIGNEMNT {results['assignment']}")
                if assn['assignment'] != results['assignment']:
                    temp_list.append(assn)
            temp_list.append(results)
            
            for item in temp_list:
                print(f"ITEM + {item}")
            self.collection.update_one({"_id":id},{"$set":{"assignments":temp_list}})
                    
                    
            #print(f"EXISTING USER {existing_user['assignments']}")
               
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
    mu.get_all_class_names()
    # mu.check_existing_user('johndoe')
   
