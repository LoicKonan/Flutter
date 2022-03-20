import hashlib
import os

from app.api.constants import _Login_Constant
from models.models import User, UserInDB
from passlib.context import CryptContext
from models.constant_model import constant
class LoginUtility:
    def __init__(self):
        self.pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
        self.constants = _Login_Constant()

    def verify_password(self, plain_password, hashed_password):
        return self.pwd_context.verify(plain_password, hashed_password)

    def get_user(self, db, username: str):
        if username in db:
            user_dict = db[username]
            print(user_dict)
            return UserInDB(**user_dict)


    def get_password_hash(self, password):
        return self.pwd_context.hash(password)
    def get_secret_key(self):
        return self.constants.SECRET_KEY
    def get_algorithm(self):
        return self.constants.ALGORITHM
    def get_expiration_time(self):
        return self.constants.ACCESS_TOKEN_EXPIRE_MINUTES


