import cv2
from sonoptix_driver.sonoptix_http import SonoptixHTTP
from sonoptix_driver.config_manager import ConfigManager
from sonoptix_driver.utils.helper_functions import get_default_config_path

class SonoptixDriver:
    def __init__(self,sonar_ip='192.168.2.42',config_path=None):
        self.rtsp_url = f'rtsp://{sonar_ip}:8554/raw'
        self.__init_config_path(config_path)
        self.sonar_ip=sonar_ip
        #to automatically change height (couldn't find any better solution to not break the pipeline)
        self.frame_height=[200, 404, 608, 808, 1012, 1024]
        self.range_list=[3, 6, 9, 12, 15, 20]

        self.configManager=ConfigManager(self.config_path)
        self.sonoptixHTTP=SonoptixHTTP(self.sonar_ip)
        #this attribute is automatically updated when sending a new 
        #config to the sonar
        self.current_config=None
        self.init_sonar_config()

        self.cap = cv2.VideoCapture(self.rtsp_url)



    def __init_config_path(self,config_path):
        if config_path is None:
            self.config_path = get_default_config_path()
        else:
            self.config_path=config_path

    def init_sonar_config(self):
        self.sonoptixHTTP.send_config(self.configManager)
        self.current_config=self.sonoptixHTTP.receive_config()
        print("sent and received config")


    def send_config_to_sonar(self,config_dict):
        self.configManager.load_config(config_dict=config_dict)
        self.sonoptixHTTP.send_config(self.configManager)
        self.current_config=self.sonoptixHTTP.receive_config()
        print("sent and received config")
        #self.reset_cap(config_dict["/api/v1/transponder"]["sonar_range"])
        self.reset_cap()

    def process_frames(self):
        if not self.cap.isOpened():
            print(f"Error: Could not open stream {self.rtsp_url}")
            return

        while self.cap.isOpened():
            success, frame = self.cap.read()
            print(len(frame))
            if not success:
                print("Error: Failed to capture frame")
                break
            
            gray_frame=cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            cv2.imshow('Sonoptix raw frame', gray_frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                self.sonoptixHTTP.stop_stream()
                self.current_config=self.sonoptixHTTP.receive_config()

        self.cap.release()
        cv2.destroyAllWindows()
    
    """
    def reset_cap(self,range):
        if(range>=20):
            new_frame_height=self.frame_height[-1]
        else:
            new_frame_height=self.frame_height[self.range_list.index(range)]
        self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT,new_frame_height)
        #self.cap.release()
        #self.cap=cv2.VideoCapture(self.rtsp_url)
    """
    def reset_cap(self):
        #self.cap.release()
        self.cap=cv2.VideoCapture(self.rtsp_url)
        #self.cap.set(cv2.cap_prop,1)

"""
if __name__ == '__main__':
    sonar_ip = '192.168.2.42'  
    driver = SonoptixDriver(sonar_ip)
    driver.send_config_to_sonar(config_dict={"/api/v1/streamtype": {"value": 2},
                                                    "/api/v1/transponder":{"sonar_range": 3}})
    driver.process_frames()
    """