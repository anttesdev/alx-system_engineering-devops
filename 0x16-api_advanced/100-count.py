#!/usr/bin/python3
"""
A script that counts the number of key words used
in a subreddit articles
"""

import requests


def count_words(subreddit, word_list, after=None, counts={}):
    """
    A function that counts keywords in a subbreddit hot
    articles
    """
    if after is None:
        url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    else:
        url = ("https://www.reddit.com/r/{}/hot.json?after={}"
               .format(subreddit, after))

    headers = {'User-Agent': 'custom'}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code != 200:
        return

    data = response.json()
    children = data['data']['children']

    for post in children:
        title = post['data']['title'].lower()
        for word in word_list:
            if word.lower() in title:
                counts[word.lower()] = (counts.get(word.lower(), 0) +
                                        title.count(word.lower()))

    next_after = data['data']['after']
    if next_after is not None:
        return count_words(subreddit, word_list,
                           after=next_after, counts=counts)
    else:
        sorted_counts = sorted(counts.items(), key=lambda x: (-x[1], x[0]))
        for word, count in sorted_counts:
            print("{}: {}".format(word, count))
