import shutil
import subprocess
from subprocess import PIPE, run

from utilities.cpp_utility import CPPUtility
from utilities.mongo_utility import MongoUtility
from utilities.utility import Utility
import os
from rich import print as richp
from fastapi import HTTPException
from os.path import isfile, join
from os import chdir, getcwd, walk
from os.path import exists
from pprint import pprint
import subprocess
from subprocess import Popen, PIPE
from .file_utility import FileUtility

class CmakeUtility(Utility):
    def __init__(self):
        self.whatever = ''
        self.fu = FileUtility()
        self.mu = MongoUtility()
        self.cppu = CPPUtility()
        self.start_dir = os.getcwd()
    def create_make_list(self, class_name, student_name, assn_num, file_list):
        # Create student directory if non existent/existent
        self.fu.create_student_directory( class_name, student_name)
        # store assignments in correct class/student/assignment_number
        self.fu.store_student_assn(class_name, student_name,assn_num, file_list)
        # # Make sure we are in the correct starting point b4 begin
        #
        # strip_path = os.path.join(self.start_dir,
        #                           'CPP_DIRECTORY',
        #                           class_name,
        #                           student_name,
        #                           assn_num)
        #
        # os.chdir(strip_path)
        # file_path_dir= []
        # comments = []
        # for file in file_list:
        #     file_path =os.path.join(strip_path, file.filename)
        #     file_path_dir.append(file_path)
        #     x = self.cppu.collect_cpp_comments(file_path)
        #     comments.append(x)
        # richp(f'COMMENTS = {comments}')
        # os.chdir(self.start_dir)


        # #self.mu.store_cpp_file_list(class_name, student_name, file_list)
        # name_list = []
        # for file in file_list:
        #     name_list.append(str(file.filename))
        # print(name_list)
        # name_list = " ".join(name_list)
        # make_text = f'cmake_minimum_required(VERSION 3.20)\n' \
        #             f'set(CMAKE_CXX_STANDARD 20)\n' \
        #             f'set(CMAKE_CXX_STANDARD_REQUIRED ON)\n' \
        #             f'project({class_name}_{student_name} VERSION 1.0)\n' \
        #             f'add_executable(${{PROJECT_NAME}} ' \
        #             f'{name_list})\n'
        # richp(make_text)
        # path = join(self.start_dir,
        #             'CPP_DIRECTORY',
        #             class_name,
        #             student_name,
        #             assn_num
        #             )
        # os.chdir(path)
        #
        # with open('CMakeLists.txt', 'w') as makefile:
        #     makefile.write(make_text)
        #
        # os.system('cmake -S . -B .')
        # os.system('make')
        # os.chdir(self.start_dir)
        # #######################################
        # with open('input.txt') as input_file:
        #     lines = input_file.readlines()
        # p = Popen([f'./{class_name}_{student_name}'],
        #           shell=False,
        #           stdout=PIPE,
        #           stdin=PIPE)
        # results = []
        # for line in lines:
        #     print(line)
        #     value = str(line) + '\n'
        #     value = bytes(value, 'UTF-8')
        #     p.stdin.write(value)
        #     p.stdin.flush()
        #     result = p.stdout.readline().strip()
        #     results.append(result)
        # return results
            # try:
        #     result = run(f'./{class_name}_{student_name}',
        #                  stdin=lines,
        #                  stdout=PIPE,
        #                  universal_newlines=True,
        #                  shell=False)
        # except Exception as e:
        #     print(e)
        # print(result)
if __name__=='__main__':
    cu = CmakeUtility()
    cu.create_make_list('test','buddy smith','P03')


