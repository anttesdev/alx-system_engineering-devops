#!/usr/bin/python3
"""
A script that returns all the hot articles of a subreddit
"""


import requests


def recurse(subreddit, hot_list=[], after=None):
    """
    A script that returns all the hot list of a subreddit
    """
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {"User-Agent": "custom"}
    params = {"after": after}

    try:
        response = requests.get(url, headers=headers,
                                params=params, allow_redirects=False)
        if response.status_code == 200:
            data = response.json()
            all_data = data['data']['after']
            if all_data is not None:
                after = all_data
                recurse(subreddit, hot_list)
            total_titles = response.json().get("data").get("children")
            for title_ in total_titles:
                hot_list.append(title_.get("data").get("title"))
            return hot_list
        else:
            return None
    except requests.RequestException:
        return None
