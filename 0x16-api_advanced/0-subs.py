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
    Custom = "python:subreddit.subscriber.counter:v1.0 (by /u/Anteneh)"
    headers = {"User-Agent": Custom}

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        if response.status_code == 200:
            data = response.json()
            return data['data']['subscribers']
        else:
            return 0
    except requests.RequestException:
        return 0
