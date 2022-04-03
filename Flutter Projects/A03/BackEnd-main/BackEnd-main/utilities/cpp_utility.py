

import os


import re
import logging
from subprocess import PIPE, run
from pprint import pprint

# Global Decoration for logger
from utilities.utility import Utility

logger = logging.getLogger('cpp_logger')
class CPPUtility(Utility):
    '''
    @member: cpp_files: list of cpp_files used for compilations
    @member: executables: optional: list of names for execuatable files
    @member: options: list of g++ parameter options (INCOMPLETE)
    @member: assn_num: str representing the assignment number being compiled
             and graded.
    @member: comments: str used to hold comments within c++ files compiled
    !TODO: Finish implementing options parameters.  Comments stripping is still
           a bit buggy.
    @method:  check_params(self,**kwargs)
              @return str
    @method:  run_cpp(self, **kwargs)
              @return dict
    '''
    def __init__(self):
        self.cpp_files: list = []
        self.executables: list = []
        self.options: list = []
        self.assn_num: str = ''
        self.results: dict = {}
        self.git_path:  str = ''
        self.cmd_args: str =''




    def check_params(self, **kwargs) -> str:
        '''
        :argument:   "cpp_file=" -> list of cpp files to be compiled
        :             type: list of strings
        :argument:   "assn_num=" -> Assignment number to be graded
        :argument:   "options" -> Compile options.  g++ optional parameters
        :TODO:        build cmake options in future.
        :description: The function checks that required valid parameters of
        been passed within kwargs.  Optional parameter values are automatically
        generated to ensure functionality within later compilations

        '''
        message: str = ''
        try:
            if kwargs['cmd_args']:
                self.cmd_args = kwargs['cmd_args']
        except KeyError as k:
            print(k)
        try:
            if kwargs['git_path']:
                self.git_path = kwargs['git_path']
        except KeyError as e:
            message += f'Failed to include correct path to git directory. \n {e}'
        try:
            if kwargs['assn_num']:
                self.assn_num = kwargs['assn_num']
        except KeyError:
            message += 'Failed to pass Assignment Number\n'
        try:
            # check correct file extension of supplied file name and existence
            # of parameter itself
            self.cpp_files: list = kwargs["cpp_file"]

            if type(self.cpp_files) == list:
                # check for correct file type
                for cpp_file in self.cpp_files:
                    cpp_file = f'{self.git_path}{cpp_file}'
                    print(cpp_file)
                    regexp = re.compile('.cpp')
                    if not regexp.search(cpp_file):
                        message += f'Invalid file name: {cpp_file}\n'

        except KeyError as e:
            message += f'Dictionary {e}.  **kwargs["cpp_file"] is a required' \
                       f' parameter.'
        try:
            # Merely check to ensure existence of Assignment number to be
            # returned to the Database Utilities module
            assn_num = str(kwargs['assn_num'])
        except KeyError:
            message += f'Missing argument.  **kwargs["assn_num"] is a ' \
                       f'required parameter.\n'
        self.executables: list = []
        try:

            if kwargs['executable']:
                # kwargs['executables is a valid list, set var executables
                # to contents for easier usage and readability
                self.executables = kwargs['executable']
        except KeyError:
            # No executables have been passed, create generic list of
            # executable file names.  Format = "executable" + x starting
            # at 0. x represents length of cppfiles passed
            for i in range(len(self.cpp_files)):
                self.executables.append(f'executable{str(i)}')


        if not len(self.executables) == len(self.cpp_files) :
            # Ensure length of executable and cpp_files are the same for
            # build and compilation
            message += 'cpp_file and executables are mismatched in length. \n'
        if len(message) == 0:
            message = "all parameters passed"
        try:
            if kwargs['options']:
                # if options exist, save to options, if not oh well, parse all
                # comments options has been passed
                self.options = kwargs['options']
        except KeyError:
            pass
        self.options.append('-Wall -std=c++11 ')
        return message
    def run_cpp(self, **kwargs):
        '''
        :param:    kwargs:
        :argument: "cpp_file=" -> list of cpp files to be compiled
        :          type: list of strings
        :argument: "assn_num=" -> Assignment number to be
        :                         graded
        :          type: string
        :argument  "options=" -> INCOMPLETE
        :          type: list of strings
        :description: Given that check_params returns 'all parameters passed'
                    : cpp_files and executables are formed into a dictionary
                    : for easier processing and iteration. Each cpp_file has
                    : its comments stored
        :todo: stripping of comments is buggy, needs fix
        :todo: add path for compilations to occur within. Compilation must
        :      occur within the venv.
        :
        '''
        result = self.check_params(**kwargs)
        if result == "all parameters passed":
            # create dictionary of cppfiles with executable fil names
            zip_list = dict(zip(self.cpp_files, self.executables))
            # join options into one string
            pprint(zip_list)
            option_str = ''.join(self.options)
            print(f'OPTION_STR = {option_str}')
            for key, value in zip_list.items():
                #self.collect_cpp_comments(key)
                # with open(key, 'r') as c_file:
                #     # open c file and string comments from it
                #     content = c_file.read()
                #     regex = re.compile(r'((\/\/(.*?))\n|(\/\*(.|\n)*\*\/))', re.DOTALL | re.MULTILINE)
                #     # return regexp from content
                #     found = regex.finditer(content)
                #     self.results[key] = {}
                #     print(f'Found = {found}')
                #     self.results[key]['comments'] = ''
                #     for match in found:
                #         self.results[key]["comments"] += match.group(0)
                #
                #     self.results[key]["lines"] = str(self.results[key][
                #         "comments"]).count('\n')
                #     print(self.results[key]["lines"])
                #     print(self.results[key]['comments'])
                print(f'I am making it here {str(key)}')
                print(f'The git path is {self.git_path}')
                os.chdir(f'{self.git_path}')
                dir = os.system('pwd')
                #print(f'The current working directory is {os.system("pwd")}')
                os.system(f"g++ -c -std=c++20 *.cpp")
                os.system(f"g++ *.o -o  main.o")

                try:
                    result = run('./a.o', stdout=PIPE, universal_newlines=True,
                             shell=False)
                except Exception as e:
                    print(e)
                print(result)
                self.results[key] = {}
                self.results[key]['output'] = result
            pprint(self.results)
        else:
            print(result)
    def collect_cpp_comments(self, cpp_file):
        if os.path.exists(cpp_file):
            with open(cpp_file ,'r') as c_file:
                # open c file and string comments from it
                content = c_file.read()

                regex = re.compile(r'((\/\/(.*?))\n|(\/\*(.|\n)*\*\/))',
                                   re.DOTALL | re.MULTILINE)
                # return regexp from content
                found = regex.finditer(content)

                self.results[cpp_file] = {}
                print(f'Found = {found}')
                self.results[cpp_file]['comments'] = ''
                for match in found:
                    self.results[cpp_file]["comments"] += match.group(0)
                    print(self.results[cpp_file]["comments"] )

                self.results[cpp_file]["lines"] = str(self.results[cpp_file][
                                                     "comments"]).count('\n')
                print(self.results[cpp_file]["lines"])
                print(self.results[cpp_file]['comments'])
        else:
            print(f'File does not exists')
        return self.results
    def count_total_lines(self, cpp_file):
        with open(cpp_file) as input_file:
            lines = input_file.readlines()
        return len(lines)

if __name__=='__main__':
    gu: CPPUtility = CPPUtility()
    ret = gu.run_cpp(cpp_file=["P01.cpp"],
                     assn_num="P01",
                     git_path='/Users/drewsmith/PycharmProjects/BackEnd/repos/3013_Fall_22/test')

