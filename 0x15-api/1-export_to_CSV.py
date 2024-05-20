#!/usr/bin/python3
"""
A python script that will export data in to CSV format
of employee_id, names, whether a task is completed and
the title of task
"""

import csv
import requests
import sys


def employee_export_csv(employee_id):
    """
    export to csv employees tasks
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
    filename = '{}.csv'.format(employee_id)
    with open(filename, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        for task in todo_list:
            writer.writerow([
                employee_id,
                employee_name,
                str(task['completed']),
                task['title']
            ])


if __name__ == '__main__':
    employee_export_csv(sys.argv[1])
