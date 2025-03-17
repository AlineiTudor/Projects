import sonoptix_driver.utils.helper_functions as hfunc
import requests
import json
from sonoptix_driver.config_manager import ConfigManager


class SonoptixHTTP:
    def __init__(self,sonar_ip='192.168.2.42'):
        #a dictionary with all endpoints as keys and permitted http request method as value
        self.endpoints_dict=hfunc.get_endpoints_dict()
        self._sonar_ip=sonar_ip
        self.current_config={}
    
    def send_config(self,configManag):
        api_url=f'http://{self._sonar_ip}:8000'
        #accepts as argument a ConfigManager object and uses configManag.config_dict field
        config=configManag.config_dict
        for endpoint in config:
            try:
                if 'put' in self.endpoints_dict[endpoint]:
                    print(config[endpoint])
                    response=requests.put(api_url+endpoint,json=config[endpoint])
                elif 'patch' in self.endpoints_dict[endpoint]:
                    print(config[endpoint])
                    response=requests.patch(api_url+endpoint,json=config[endpoint])

            except Exception as e:
                print(f"Error sending put/patch request: {str(e)}")
    
    @property
    def sonar_ip(self):
        return self._sonar_ip

    @sonar_ip.setter
    def sonar_ip(self,new_sonar_ip='192.168.2.42'):
        try:
            result=requests.put(f'http://{self._sonar_ip}:8000/api/v1/network/static',
                                  json={"address": new_sonar_ip,
                                        "netmask": "255.255.255.0",
                                        "router": ""},timeout=2)
            print(f"Successfully changed sonar ip to: {self._sonar_ip}")
            self._sonar_ip=new_sonar_ip
            #response.raise_for_status()
            
        except Exception as e:
            raise Exception(f"Could not change sonar ip. Error: {str(e)}")

    
    def receive_config(self):
        for endpoint in self.endpoints_dict:
            if 'get' in self.endpoints_dict[endpoint]:
                result=requests.get(f'http://{self._sonar_ip}:8000'+endpoint)
                self.current_config[endpoint]=json.loads(result.content.decode())
        return self.current_config


    def stop_stream(self):
        try:
            result=requests.patch(f"http://{self.sonar_ip}:8000/api/v1/transponder",json={
                "enable": False
            })
            if result.status_code==200:
                print("Successfully stopped sonar pinging")
        except Exception as e:
            print(f"Could not stop sonar ping.\n",
                  "Probably your sonar IP does not corespond to the real sonar IP.\n",
                  e)
            

#a=SonoptixHTTP('192.168.2.42')
#a.stop_stream()
"""
a=SonoptixHTTP('192.168.2.42')
c=ConfigManager("/home/tudor/catkin_ws/src/sonoptix_pkg/src/config_example/config.yaml")
a.send_config(c)


for key in a.current_config:
    print("---------\n")
    #print(type(a.current_config[key]))
    x=json.loads(a.current_config[key])
    print(x["value"])
    print("----------\n")"""