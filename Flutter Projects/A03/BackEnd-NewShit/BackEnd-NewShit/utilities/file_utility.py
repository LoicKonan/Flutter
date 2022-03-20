from utilities.utility import Utility
import os
import shutil

class FileUtility(Utility):
    def __init__(self):
        self.cwd = ''

    def create_directory(self, class_name, student, assn_num, file_list):
        os.chdir('../')
        cwd = os.getcwd()
        cwd = os.path.join(cwd, 'CPP_DIRECTORY')
        expected_path = os.path.join(cwd, class_name)
        self.check_creation_path(cwd)
        self.check_creation_path(expected_path)
        self.check_creation_path(os.path.join(expected_path, student))
        self.check_creation_path(
            os.path.join(expected_path, student, assn_num))
        parsed_path = os.path.join(expected_path, student, assn_num)
        self.store_cpp_files(file_list, parsed_path)

    def store_files(self, files: list, write_path):
        for image in files:
            path = os.path.join(write_path, image.filename)
            print(path)
            try:
                with open(path, "wb") as buffer:
                    shutil.copyfileobj(image.file, buffer)
            except Exception:
                print(f'An exception occurred of type {Exception}')

    def check_creation_path(self, expected_path):
        if not os.path.exists(expected_path):
            os.mkdir(expected_path)
            os.chdir(expected_path)