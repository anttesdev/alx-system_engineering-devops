#!/usr/bin/python3
"""
A python script that lists all the tasks of
employees, with their ids, and task status
as a JSON
"""

import json
import requests


def employee_export_json():
    """
    Script exports employee todo list
    information as JSON
    """
    users_url = 'https://jsonplaceholder.typicode.com/users'
    users_response = requests.get(users_url)
    users = users_response.json()

    all_tasks = {}

    for user in users:
        employee_id = user['id']
        employee_name = user['username']

        todos_url = 'https://jsonplaceholder.typicode.com/todos'
        params = {'userId': employee_id}
        todos_response = requests.get(todos_url, params=params)
        todo_list = todos_response.json()

        tasks = [{
            'username': employee_name,
            'task': task['title'],
            'completed': task['completed'],
        } for task in todo_list]

        all_tasks[str(employee_id)] = tasks

    filename = 'todo_all_employees.json'
    with open(filename, 'w') as jsonfile:
        json.dump(all_tasks, jsonfile)


if __name__ == '__main__':
    employee_export_json()
