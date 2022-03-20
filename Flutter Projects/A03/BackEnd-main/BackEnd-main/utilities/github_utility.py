import csv


from pprint import pprint


import requests
import os



class Github_Utility:
    def __init__(self):
        '''
        :var response -> str: used to restore reponse from google docs api
        '''
        self.response: str = ''

    def import_google_class(self, document_id, class_name):
        '''
        :name: import_google_class
        :param document_id -> str:
        :param class_name -> str:
        :description: Given a google document id, representing a table
        :             document. The method calls googles api, collects the
        :             document in CSV form, cleans the data by removing the
        :             image and the avatar, obviously in future iterations,
        :             values to be removed will need to be passed via calls.
        :             A dictionary is then created and a function call is
        :             passed to create student repos within the VENV
        :return: None
        '''
        # d/1f8bAaOnt9maLomWO3WWXTwb7yqCbTVavk1FJo-BNYL4
        doc_url = f'https://docs.google.com/spreadsheets/d/{document_id}' \
                  f'/gviz/tq?tqx=out:csv&sheet=Sheet1'
        self.response = ''
        try:
            with requests.Session() as session:
                self.response = session.get(doc_url)
        except requests.HTTPError as e:
            return "Failed to connect to Google_Doc api"
        self.response = self.response.content.decode('utf-8')
        self.response = list(csv.reader(self.response.splitlines(),
                                      delimiter=','))
        for i in range(len(self.response)):
            while('' in self.response[i]):
                self.response[i].remove('')
            column_values = []
            class_list = []
            for i in range(len(self.response)):
                print(self.response[i])
                while ('' in self.response[i]):
                    self.response[i].remove('')
                if i == 0:
                    try:
                        self.response[i].remove('Image')
                        self.response[i].remove('Avatar')
                    except Exception as e:
                        pass
                    column_values = self.response[i]
                else:
                    item = dict(zip(column_values, self.response[i]))
                    class_list.append(item)
            pprint(class_list)
        self.create_class_repos(class_name, class_list)

    def create_class_repos(self, class_name: str, class_data: list):
        '''
        :name: create class repos
        :param class_name -> str: Name of class
        :param class_data -> list of dictionary entries:  contains a list of
        :                    student information pertaining to GITHUB and
        :                    pertinent data.
        :description:   Given the passed lists class_data, each dictionary
        :               entry is used to create a repo containing each students
        :               repos for the class.
        :TODO           Find solution for nested github repos, aka .gitignore
        :               or something similiar
        :return: none
        '''
        if not os.path.isdir('../repos'):
            print('making repos directory')
            os.mkdir('../repos')
            os.mkdir(f'../repos/{class_name}')
        if not os.path.isdir(f'../repos/{class_name}'):
            os.mkdir(f'../repos/{class_name}')
        os.chdir(f'../repos/{class_name}')
        for student_dict in class_data:
            for key, value in student_dict.items():
                if key == 'Link to Github Repo':
                    value = value[18:]
                    git_msg = f'git clone git@github.com:{value}'
                    os.system(git_msg)


    def pull_current_changes(self, class_name):
        '''
        :param: class_name -> str: represent the class name contained within
        :                          the repo folder from which you wish to pull
        :                          recent changes
        :return: None at the moment, eventually a list of failed repos
        '''
        if os.path.isdir('../repos'):
            os.chdir('../repos')
            directories = os.listdir('.')
            if os.path.isdir(class_name):
                os.chdir(class_name)
                student_directories = os.listdir('.')
                for item in student_directories:
                    os.chdir(item)
                    os.system('git pull')
                    os.chdir('cd ..')
        else:
            return 'Missing folder "repos". Unable to pull student changes'


if __name__=='__main__':
    gu = Github_Utility()
    gu.import_google_class("1jAkhTTA8b8BxF5ckkyct44jOz8PNmREB9QxGERVDSeY",
                           '4883_programming_techniques')
    gu.pull_current_changes('4883_programming_techniques')