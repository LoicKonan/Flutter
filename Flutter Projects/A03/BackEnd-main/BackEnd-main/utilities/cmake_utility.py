from copy import deepcopy
import fileinput
import json
import shutil
import subprocess
import sys
from subprocess import PIPE, run
from models.models import ReturnProcess

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
        # very specific acceptance criteria, input=input.txt,
        # output=results.txt.  Scenario will fail if varied from these params
        # returns string of results.txt
        os.chdir(self.start_dir)
        return_dict = {}
        return_dict['student_name'] = student_name
        return_dict['assignment'] = assn_num
        # Create student directory if non existent/existent
        self.fu.create_student_directory( class_name, student_name)
        # store assignments in correct class/student/assignment_number
        self.fu.store_student_assn(class_name, student_name,assn_num, file_list)
        # Make sure we are in the correct starting point b4 begin

        strip_path = os.path.join(self.start_dir,
                                  'CPP_DIRECTORY',
                                  class_name,
                                  student_name,
                                  assn_num)
        #
        os.chdir(strip_path)
        print(os.getcwd())
        # if os.path.exists(strip_path):
        #     print('Somethings good')
        file_path_dir= []
        comments = []
        for file in file_list:


            file_path =os.path.join(strip_path, file.filename)
            if file_path.endswith('cpp'):
                print('FILE FOUND HOOYAH')
                file_path_dir.append(file_path)
                x = self.cppu.collect_cpp_comments(file_path)
                if x:
                    comments.append(x)

        return_dict['comments'] = comments
        # # os.chdir(self.start_dir)
        #
        #
        self.mu.store_cpp_file_list(class_name, student_name, file_list)
        name_list = []
        for file in file_list:
            file_name = str(file.filename)
            if file_name.endswith('cpp'):
                name_list.append(str(file.filename))
        print(name_list)
        name_list = " ".join(name_list)
        make_text = f'cmake_minimum_required(VERSION 3.16.3)\n' \
                    f'set(CMAKE_CXX_STANDARD 20)\n' \
                    f'set(CMAKE_CXX_STANDARD_REQUIRED ON)\n' \
                    f'project({class_name}_{student_name} VERSION 1.0)\n' \
                    f'add_executable(${{PROJECT_NAME}} ' \
                    f'{name_list})\n'
        richp(make_text)
        print(os.getcwd())
        # # path = join(self.start_dir,
        # #             'CPP_DIRECTORY',
        # #             class_name,
        # #             student_name,
        # #             assn_num
        # #             )
        # # os.chdir(path)
        # #
        with open('CMakeLists.txt', 'w') as makefile:
            makefile.write(make_text)
        # #
        #subprocess.call('cmake -S . -B .')
        try:
            os.system('cmake -S . -B .')
            
        except Exception as e:
            print(e)
        #
        result = run('make',
                      stdin=PIPE,
                      stdout=PIPE,
                      universal_newlines=True,
                      shell=False)
        return_dict['make'] = dict()
        return_dict['make']['stdout'] = result.stdout
        return_dict['make']['stderr'] = result.stderr
        return_dict['make']['returncode'] = result.returncode
        
        # print(os.getcwd())
        # # os.chdir(self.start_dir)
        # # # #######################################
        # with open('input.txt') as input_file:
        #     lines = input_file.readlines()
        # #
        std_input = open('input.txt')
        std_output = open('std_output.txt', 'w+')
        # #################################################
        # file_input = fileinput.input(files="input.txt")
        p = Popen([f'./{class_name}_{student_name}'],
                  shell=False,
                  stdout=PIPE,
                  stdin=std_input,
                  stderr=std_output,
                  universal_newlines=True)
        ret = p.wait()
        print('Writing cout ')
        cout = ""
        print(f'STDERR = {p.stderr}')
        if p.stdout:
            for line in p.stdout:
                cout += line
        return_dict['stdout'] = cout
        # std_output.flush()
        # print(os.getcwd())
        with open('results.txt', 'r') as file:
            results = file.read()
        return_dict['results'] = results
        os.chdir(self.start_dir)
        print(type(return_dict['make']))
        
        print(type(return_dict['stdout']))
        print(type(return_dict['comments']))
        pprint(return_dict, indent=4)
        # Store results in database
        self.mu.store_student_results(class_name, student_name, assn_num,return_dict)
        json_obj = json.dumps(return_dict)
        return json_obj

if __name__=='__main__':
    cu = CmakeUtility()
    cu.create_make_list('test','buddy smith','P03')


