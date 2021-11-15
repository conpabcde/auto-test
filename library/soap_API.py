import requests
from robot.api.deco import keyword
from robot.api import logger
from robot.api import TestSuite
from robot.api import ResultWriter


def post_soap_api(url):
    headers = {'content-type': 'application/xml'}
    response = requests.post(url, headers=headers)
    print(response.content)
    return response.content
