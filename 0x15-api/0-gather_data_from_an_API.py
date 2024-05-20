#!/usr/bin/python3
"""
A Python script that, uses a REST API, for a given employee ID,
returns information about his/her TODO list progress.
"""

import requests
import sys


def fetch_employee_todo_list(employee_id):
    """
    a function that will fetch the progress of an
    employees progress
    """

    url = 'https://jsonplaceholder.typicode.com/todos'

    params = {'userId': employee_id}

    response = requests.get(url, params=params)

    todo_list = response.json()

    employee_name = (
                     requests.get(
                         'https://jsonplaceholder.typicode.com/users/{}'
                         .format(employee_id)).json().get('name')
                     )

    total_tasks = len(todo_list)
    completed_tasks = sum(task['completed'] for task in todo_list)

    print("Employee {} is done with tasks({}/{}):"
          .format(employee_name, completed_tasks, total_tasks))
    for task in todo_list:
        if task['completed']:
            print("\t{}".format(task['title']))


if __name__ == '__main__':
    fetch_employee_todo_list(sys.argv[1])
