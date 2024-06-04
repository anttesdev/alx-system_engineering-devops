#!/usr/bin/python3
"""
A script that will return the hot 10
posts of a subreddit
"""


import requests


def top_ten(subreddit):
    """
    A function that queries the Reddit API and prints
    the titles of the first 10 hot posts listed for a given subreddit
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "custom"}
    params = {"limit": 10}

    try:
        response = requests.get(url, headers=headers,
                                params=params, allow_redirects=False)
        if response.status_code == 200:
            data = response.json()
            posts = data.get('data', {}).get('children', [])
            if not posts:
                print(None)
            else:
                for post in posts:
                    print(post.get('data', {}).get('title', None))
        else:
            print(None)
    except requests.RequestException:
        print(None)
