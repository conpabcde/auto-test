import time
import hashlib
import json
import requests
import param

current_milli_time = lambda: int(round(time.time()*1000))

s = hashlib.sha1()

class api_helper(object):

    def __int__(self):
        self.app_secret = ""
        self.sign = ""
        self.timesign = ""
        self.query_string = ""

    def encrypt_sign(self, _appKey):
        self.app_secret = param.APPKEY_APPSECRET[_appKey]
        s = hashlib.sha1()
        self.timesign = current_milli_time()
        data = (self.app_secret+"+"+str(self.timesign))
        s.update(data)
        self.sign = s.hexdigest()
        self.query_string = {'appkey': _appKey, 'timestamp': self.timesign,
                'sign': self.sign}

    def show(self):
        log("appId", self.query_string)

    def get_api_sign(self):
        return self.sign

    def get_api_timesign(self):
        return self.timesign

    def post_api_response(self, appKey, payload, uri):
        url = param.HOST+uri
        self.encrypt_sign(appKey)
        headers={'Content-Type': 'application/json; charset=utf8'}
        response = requests.post(url, params=self.query_string,
                data=str(payload),
                headers=headers)
        return response

#api_helper = api_helper()
#payload = '{"type":1,"mobile":"9041511795"}'
#uri = '/account/otpcode'
#rc = api_helper.get_api_response("xykCpNxU", "get", payload, uri)
#print(api_helper.show)
#print(api_helper.timesign)
#print(api_helper.reponse)
#print "xykCpNxU"
#print rc
#print(api_helper.query_string)