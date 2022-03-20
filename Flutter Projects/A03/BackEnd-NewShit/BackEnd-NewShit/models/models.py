from pydantic import BaseModel
from typing import Optional

class FileUpload(BaseModel):
    language: str
    author: str
    extensions: str

class RegisterUser(BaseModel):
    fullname: str
    username: str
    password: str
    email: str

class User(BaseModel):
    username: str
    fullname: str
    email: str
    hashed_password: Optional[str]
    disabled: bool
    password: Optional[str]


class UserInDB(User):
    hashed_password: str

class TokenData(BaseModel):
    hashed_password: str
class Token(BaseModel):
    access_token: str
    token_type: str

class FailedResponse(BaseModel):
    status_code: str
    details: str
    expected_parameters: str

