import shutil

from utilities.utility import Utility
import os
from fastapi import HTTPException
from os.path import isfile, join
from os import chdir, getcwd, walk
from os.path import exists
from pprint import pprint
class CmakeUtility(Utility):
    def __init__(self):
        self.whatever = ''
    def create_make_list(self, class_name, student_name, assn_num):
        try:
            os.chdir('../')
            poss_path = join(
                getcwd(),
                'CPP_DIRECTORY',
                class_name,
                student_name,
                assn_num)
            if exists(poss_path):
                print('path does exists bitches')
                chdir(poss_path)
            else:
                print(f'Invalid file path given: \n\t{poss_path}')

        except OSError as e:
            print('NON-EXISTENT directory path taken')





        file_list = []
        for(dirpath, dirnames, filenames) in walk(poss_path):
            file_list.extend(filenames)
            break
        print(file_list)
        make_text = f'cmake_minimum_required(VERSION 3.20)\n' \
                    f'set(CMAKE_CXX_STANDARD 20)\n' \
                    f'set(CMAKE_CXX_STANDARD_REQUIRED ON)\n' \
                    f'project({class_name}_{student_name} VERSION 1.0)\n' \
                    f'add_executable(${{PROJECT_NAME}} ' \
                    f'{" ".join(file_list)}])\n'
        pprint(make_text)
if __name__=='__main__':
    cu = CmakeUtility()
    cu.create_make_list('test','buddy smith','P03')



