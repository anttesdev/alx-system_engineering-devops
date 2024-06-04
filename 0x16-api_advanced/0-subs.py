#!/usr/bin/python3
"""
A function that queries Reddit API and returns total subscribers
and if not return 0
"""


import requests


def number_of_subscribers(subreddit):
    """
    Function that gets the number of subscribers from a Subreddit
    """

    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {"User-Agent": "Custom"}

    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        data = response.json()
        return data['data']['subscribers']
    else:
        return 0
