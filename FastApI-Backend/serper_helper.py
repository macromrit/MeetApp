import http.client
import json

import os
from dotenv import load_dotenv

load_dotenv()

SERPER_API_KEY = os.environ['SERPER_API_KEY']


def getPlaces(places_query: str):
    conn = http.client.HTTPSConnection("google.serper.dev")
    payload = json.dumps({
    "q": places_query,
    })

    headers = {
    'X-API-KEY': SERPER_API_KEY,
    'Content-Type': 'application/json'
    }

    conn.request("POST", "/places", payload, headers)
    res = conn.getresponse()
    data = res.read()

    # return eval(data.decode("utf-8"))['places']
    return [(place['title'], place['address'], place['rating']) for place in eval(data.decode("utf-8"))['places']]


if __name__ == '__main__':
    print(getPlaces('Pizzerias in Boston'))
    ...