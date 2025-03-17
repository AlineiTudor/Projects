import os
import inspect

def get_endpoints():
        #endpoints_file_path=os.getcwd()
        endpoints_file_path=os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
        endpoints_file_path=endpoints_file_path.replace('/sonoptix_driver/utils','')
        endpoints_file_path=endpoints_file_path+"/config_example/endpoints.txt"
        with open(endpoints_file_path,'r') as endpfile:
            endpoints=endpfile.readlines()

        endpoints=list(filter(("\n").__ne__,endpoints))

        for k in range(len(endpoints)):
            endpoints[k]=endpoints[k].replace("\n","")
        return endpoints
    
def get_endpoints_dict():
    endpoints=get_endpoints()
    endpoints_dict={}
    for endpoint in endpoints:
        aux=endpoint.split(": ")
        endpoints_dict[aux[0]]=list(aux[1].split(", "))
    return endpoints_dict

def get_default_config_path():
    default_config_file_path=os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
    default_config_file_path=default_config_file_path.replace('/sonoptix_driver/utils','')
    default_config_file_path=default_config_file_path+"/config_example/config.yaml"
    return default_config_file_path