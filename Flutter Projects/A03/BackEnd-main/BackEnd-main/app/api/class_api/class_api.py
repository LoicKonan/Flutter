from __future__ import annotations
import uvicorn
from typing import Optional, List
from models.models import FailedResponse
from fastapi import FastAPI, File, UploadFile, APIRouter, HTTPException, status
import json
from utilities.cmake_utility import CmakeUtility
from utilities.mongo_utility import MongoUtility
from pprint import pprint
class_upload = APIRouter()
mongo_utility = MongoUtility()

@class_upload.get('/all_classes')
def get_all_classes():
    classes = mongo_utility.get_all_class_names()
    return {"classes":classes}

