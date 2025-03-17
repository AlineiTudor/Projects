#!/usr/bin/env python3


import rospy
from marine_acoustic_msgs.msg import SonarImageData , PingInfo, ProjectedSonarImage
from std_msgs.msg import Header
from geometry_msgs.msg import Vector3
import math
from sonoptix_driver.sonoptix_driver import SonoptixDriver
import cv2
from sonoptix_pkg.srv import SetConfig, SetConfigResponse
import numpy as np

#TODO:integrate with sonoptix_driver+send config to sonar(quite done, but not working smooth due to reinitializing cap in driver-couldn't find any other workaround) 
#TODO:build ROS projected image message
seq=0
class SonoptixDriverNode:
    def __init__(self,sonar_ip='192.168.2.42', config_file=None):
        self.config_file=config_file
        self.sonar_ip=sonar_ip
        self.driver=SonoptixDriver(sonar_ip=self.sonar_ip, config_path=self.config_file)
        self.projected_sonar_image_pub=rospy.Publisher('/sonoptix/data/raw',ProjectedSonarImage,queue_size=10)
        rospy.init_node('sonoptix_driver_node',anonymous=True)
        self.set_config_service=rospy.Service('set_config',SetConfig, self.handle_set_config)
        self.get_sonar_frames()
        rospy.spin()
    
    def handle_set_config(self, req):
        new_range=req.range
        new_contrast=req.contrast
        new_gain=req.gain
        new_palette=req.palette
        new_pinging_enabled=req.pinging_enabled
        new_stream_type=req.stream_type
        print(new_range, new_contrast,new_palette,new_pinging_enabled,new_stream_type,new_gain)
        config_dict=self.build_config_dictionary(new_range,new_contrast,new_gain,new_palette,new_pinging_enabled,new_stream_type)
        self.driver.send_config_to_sonar(config_dict)
        print(self.driver.configManager.config_dict)
        return SetConfigResponse(success=True)
    
    #construct PingInfo message
    def build_ping_info(self):
        pingInfo=PingInfo()
        #print(self.driver.current_config['/api/v1/transponder'])
        if self.driver.current_config['/api/v1/transponder']["sonar_range"]>=30:
            pingInfo.frequency=400000
        else:
            pingInfo.frequency=700000
        pingInfo.sound_speed=1481
        return pingInfo
    #Construct header message (we use for the time being the timestamp of the 
    #receiverd image, not when the beam was sent)
    def build_header(self):
        global seq
        header=Header()
        seq+=1
        time=rospy.Time.now()
        #header.frame_id=""
        header.seq=seq
        header.stamp=time
        return header
    #construct the directions vector
    def build_beam_directions(self):
        beam_directions=[]
        nr_beams=256
        #we consider that in the middle we have two beams which are bisected by the z axes
        beam_angles=[0]
        beam_directions=[Vector3(0,1,0)]
        for i in range(1,nr_beams):
            direction=Vector3()
            beam_angles.append(beam_angles[i-1]+0.47)
            direction.x=0
            direction.y=math.cos(math.radians(beam_angles[-1]))
            direction.z=math.sin(math.radians(beam_angles[-1]))
            beam_directions.append(direction)
        return beam_directions
    #building bin ranges vector
    def build_ranges(self):
        ranges=[]
        ranges.append(0.2)#minimum range so first bin is for 0.2 m distance
        bin_distance=self.driver.current_config['/api/v1/transponder']["sonar_range"]/self.rows
        for i in range(1,self.rows):
            ranges.append(ranges[i-1]+bin_distance)
        return ranges
    #building SonarImageData message
    def build_sonar_image_data(self,frame):
        sonarImageData=SonarImageData()
        sonarImageData.data=[]
        #print(type(sonarImageData.data))
        sonarImageData.dtype=sonarImageData.DTYPE_UINT8
        sonarImageData.beam_count=256
        for beam in range(sonarImageData.beam_count):
            #taking beam measurements from closest to furthest
            beam_data=[row[beam] for row in frame]
            for bin in range(self.rows):
                sonarImageData.data.append(beam_data[bin])
                #if(beam_data[bin]!=0):
                    #print(beam_data[bin])
        return sonarImageData
    #constructing the ProjectedSonarImage message
    def build_sonar_message(self,frame):
        projectedSonarImage=ProjectedSonarImage()
        projectedSonarImage.header=self.build_header()
        projectedSonarImage.ping_info=self.build_ping_info()
        projectedSonarImage.beam_directions=self.build_beam_directions()
        projectedSonarImage.ranges=self.build_ranges()
        projectedSonarImage.image=self.build_sonar_image_data(frame)
        return projectedSonarImage

    
    def get_sonar_frames(self):
        if not self.driver.cap.isOpened():
            rospy.logerr(f'Error: Could not open stream {self.driver.rtsp_url}')
            return
        while not rospy.is_shutdown():
            try:
                success, frame=self.driver.cap.read()
            except Exception as e:
                rospy.logerr(f'Frame could not be read: {e}')
                continue
            if not success:
                rospy.logerr("Error: Failed to capture frame")
                #break
            else:
                gray_frame=cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
                #print(len(gray_frame))
            #cv2.imshow('Sonoptix raw frame', gray_frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                self.driver.sonoptixHTTP.stop_stream()
                self.driver.current_config=self.driver.sonoptixHTTP.receive_config()
            self.rows=len(gray_frame)
            sonar_message=self.build_sonar_message(gray_frame)
            self.projected_sonar_image_pub.publish(sonar_message)
        self.driver.cap.release()
        cv2.destroyAllWindows()
    
    def build_config_dictionary(self, range, contrast, gain, palette, pinging_enabled, stream_type):
        config_dict=self.driver.configManager.config_dict
        config_dict["/api/v1/colormap/index"]["value"]=palette

        config_dict["/api/v1/config"]["contrast"]=contrast
        config_dict["/api/v1/config"]["gain"]=gain

        config_dict["/api/v1/transponder"]["enable"]=pinging_enabled
        config_dict["/api/v1/transponder"]["sonar_range"]=range

        config_dict["/api/v1/streamtype"]["value"]=stream_type
        return config_dict

if __name__ == '__main__':
    rtsp_url = '192.168.2.42'  # Replace with your actual RTSP URL
    config_file = None
    node = SonoptixDriverNode(rtsp_url, config_file)