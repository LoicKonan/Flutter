from __future__ import annotations
import uvicorn
from typing import Optional, List
from models.models import FailedResponse
from fastapi import FastAPI, File, UploadFile, APIRouter, HTTPException, status
import json
from utilities.cmake_utility import CmakeUtility
from utilities.mongo_utility import MongoUtility
from pprint import pprint
file_upload = APIRouter()
mongo_utility = MongoUtility()

@file_upload.post("/files/")
async def create_file(file: Optional[bytes] = File(None)):
    if not file:
         raise HTTPException(
            status_code=400,
            detail="Files not included in request",
            headers={"WWW-Authenticate": "Bearer"},
        )
    else:
        return {"file_size": len(file)}

# async def create_upload_file(file_list: Optional[List[UploadFile]] = None):


@file_upload.post("/uploadfile")
async def create_upload_file(collection: str,
                             student_name: str,
                             assn_num:str,
                             file_list: Optional[List[UploadFile]] = None,
                             ):
    print('Is this ever hit??????????????????')
    print(collection)
    print(student_name)
    print(assn_num)
    if file_list:
        print(f'File list exists!')
    cu = CmakeUtility()

    if not file_list:
        return FailedResponse(
            status_code=400,
            details= "Failed to recieve expected file parameters",
            expected_parameters="List[file0, file1, file2, etc, ...]"
        )
    else:
        results = cu.create_make_list(
                    collection,
                    student_name,
                    assn_num,
                    file_list)
    # for key, value in results.items():
    #     print(f'key = {key}')
    #     print(f'value={value}')
    print(type(results))
    # json_object = json.dumps(results)
    pprint(results, indent=4)
    return results
        # return_value = mongo_utility.store_cpp_file_list(collection,
        #                                               student_name, file_list)
        #
        #
        # return return_value
if __name__ == '__main__':
    uvicorn.run('file_upload:app', host='0.0.0.0', port=8080)