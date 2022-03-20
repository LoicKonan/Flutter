from datetime import datetime, timedelta
from typing import Optional
from models.models import FileUpload, User, UserInDB, Token, TokenData, RegisterUser
from fastapi import Depends, FastAPI, HTTPException, status, APIRouter
from fastapi.security import OAuth2, OAuth2PasswordBearer, \
    OAuth2PasswordRequestForm
from jose import JWTError, jwt
from passlib.context import CryptContext
from utilities.login_utility import LoginUtility
from utilities.mongo_utility import MongoUtility


login_utility = LoginUtility()
mongo_utility = MongoUtility()




#pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

authenticate = APIRouter()


def get_user(db, username: str):
    if username in db:
        user_dict = db[username]
        print(user_dict)
        return UserInDB(**user_dict)


def authenticate_user(username: str, password: str):
    # user = get_user(fake_db, username)
    user = mongo_utility.check_existing_user(username)
    print(user)
    if not user:
        return False
    if not login_utility.verify_password(password, user['hashed_password']):
        return False
    return user


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(
        to_encode,
        login_utility.get_secret_key(),
        algorithm=login_utility.get_algorithm()
    )
    return encoded_jwt


async def get_current_user(token: str = Depends(oauth2_scheme)):
    print('Get current user being called')
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(
            token,
            login_utility.get_secret_key(),
            algorithms=[
                login_utility.get_algorithm()
            ]
        )
        username: str = payload.get("sub")
        print(f'username = {username}')
        if username is None:
            raise credentials_exception
        token_data = TokenData(hashed_password=mongo_utility.get_user_hash(
            username))
    except JWTError:
        raise credentials_exception
    #user = login_utility.get_user(fake_users_db, username=username)
    user = mongo_utility.check_existing_user(username)
    if user is None:
        raise credentials_exception
    else:
        print(f'User @93 = {user}')
    return user


async def get_current_active_user(current_user: User = Depends(get_current_user)):
    if current_user['disabled']:
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user


@authenticate.post("/token", response_model=Token)
async def login_for_access_token(
        form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(
        form_data.username,
        form_data.password
    )
    print(f'User @ 104 = {user}')
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=login_utility.get_expiration_time())
    access_token = create_access_token(
        data={"sub": user['username']}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}


@authenticate.get("/users/me/", response_model=User)
async def read_users_me(current_user: User = Depends(get_current_active_user)):
    return current_user

@authenticate.post('/register', response_model=User)
async def register_user(new_user: User):

    if (new_user.password is not None) and (new_user.username is not None):
        user_exist = mongo_utility.check_existing_user(new_user.username)
        print(f'User already exists')
    else:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User failed to supply password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    if not user_exist:
        new_user.hashed_password = login_utility.get_password_hash(
            str(new_user.password)
        )

        try:
            assert new_user.hashed_password is not None
            new_user.password = None
        except AssertionError as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Password hash error",
                headers= {"WWW-Authenticate": "Bearer"})

        new_user.disabled = False
        print(new_user)
        mongo_utility.create_new_user(new_user)
    else:
        print(f'User already exists')
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="User previously registered",
            headers={"WWW-Authenticate": "Bearer"},
        )

@authenticate.get("/users/me/items/")
async def read_own_items(current_user: User = Depends(get_current_active_user)):
    return [{"item_id": "Foo", "owner": current_user.username}]
