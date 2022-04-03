from models.constant_model import constant

class _Login_Constant(object):
    @constant
    def ACCESS_TOKEN_EXPIRE_MINUTES():
        return 90

    @constant
    def SECRET_KEY():
        '''
        # openssl rand -hex 32
        :return:
        '''
        return "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"

    @constant
    def ALGORITHM():
        return "HS256"
