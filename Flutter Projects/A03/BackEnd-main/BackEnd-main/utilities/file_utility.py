from utilities.utility import Utility
import os
import shutil

class FileUtility(Utility):
    def __init__(self):
        self.start_dir = os.getcwd()

    def create_student_directory(self, class_name, student):
        os.chdir(self.start_dir)
        base_path = os.path.join(self.start_dir, 'CPP_DIRECTORY')
        self.check_creation_path(base_path)
        # Change directory to folder where all cpp files are stored
        os.chdir(os.path.join(self.start_dir, 'CPP_DIRECTORY'))

        # create class folder to hold assignments
        class_path = os.path.join(os.getcwd(), class_name)
        print(f'CLASS_PATH={class_path}')
        self.check_creation_path(class_path)    
        os.chdir(class_path)
        # create Student Folder to hold student submissions
        student_path = os.path.join(os.getcwd(),student)
        print(f'STUDENT_PATH={student_path}')
        self.check_creation_path(student_path)

        os.chdir(self.start_dir)
    def store_student_assn(self,class_name, student_name,assn_num, file_list):
        os.chdir(os.path.join(self.start_dir, 'CPP_DIRECTORY'))
        class_path = os.path.join(os.getcwd(), class_name, student_name)
        if os.path.exists(class_path):
            os.chdir(class_path)
            assn_path = os.path.join(class_path, assn_num)
            if not os.path.exists(assn_path):
                os.mkdir(assn_path)

            os.chdir(assn_path)
            for image in file_list:
                path = os.path.join(assn_path, image.filename)
                print(f'Image being written to {path}')
                try:
                    with open(path, "wb") as buffer:
                        shutil.copyfileobj(image.file, buffer)
                except Exception:
                    print(f'An exception occurred of type {Exception}')
            os.chdir(self.start_dir)
        else:
            return "Something went wrong!"

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
            


