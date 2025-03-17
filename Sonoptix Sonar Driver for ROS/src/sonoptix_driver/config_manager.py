import yaml
import sonoptix_driver.utils.helper_functions as hfunc

#the config params will be sent to the sonar from a .yaml file using as a param the file path to the config file
class ConfigManager:
    def __init__(self,config_path=None,config_dict=None):
        #getting the list of all endpoints and the HTTP methods permitted
        self.endpoints_dict=hfunc.get_endpoints_dict()

        self.config_path=config_path
        self.config_dict=self.load_config(config_path,config_dict)

    def load_config(self,config_path=None, config_dict=None):
        if config_dict is None and config_path is None:
            raise Exception("No valid config file or dictionary")
        else: 
            if config_dict is None:
                with open(self.config_path,'r') as cfile:
                    config=yaml.safe_load(cfile)
                self.val_config(config)
                return config
            elif config_path is None:
                self.val_config(config_dict)
                self.config_dict=config_dict
                return config_dict
    
    #function to validate that the config only contains endpoints that only accept put or patch methods
    def val_config(self,config_dict):
        for endpoint in config_dict:
            if endpoint not in self.endpoints_dict.keys():
                raise Exception(f"The specified endpoint {endpoint} does not exists.\n"
                                "Check endpoints.txt for the full endpoint list.")
            if ('put' not in self.endpoints_dict[endpoint]) and ('patch' not in self.endpoints_dict[endpoint]):
                raise Exception(f"The specified {endpoint} endpoint does not support put/patch requests.")
            
    
"""
a=ConfigManager("/home/tudor/catkin_ws/src/sonoptix_pkg/src/config_example/bad_config_ex.yaml")
for x in a.config_dict:
    print(f"{x}: {a.config_dict[x]}")
"""
    
