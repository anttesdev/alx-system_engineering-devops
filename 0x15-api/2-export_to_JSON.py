#!/usr/bin/python3
"""
A python script that will export data in to JSON
of employee_id, username, whether a task is completed and
the title of task, task status
"""

import json
import requests
import sys


def employee_export_json(employee_id):
    """
    export to JSON employees tasks
    """

    url = 'https://jsonplaceholder.typicode.com/todos'

    params = {'userId': employee_id}

    response = requests.get(url, params=params)

    todo_list = response.json()

    employee_name = (
                     requests.get(
                         'https://jsonplaceholder.typicode.com/users/{}'
                         .format(employee_id)).json().get('username')
                     )

    tasks = []
    for task in todo_list:
        task_info = {
            'task': task['title'],
            'completed': task['completed'],
            'username': employee_name
        }
        tasks.append(task_info)

    employee_data = {str(employee_id): tasks}

    filename = '{}.json'.format(employee_id)
    with open(filename, 'w') as jsonfile:
        json.dump(employee_data, jsonfile)


if __name__ == '__main__':
    employee_export_json(sys.argv[1])
