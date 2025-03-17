#!/usr/bin/env python3

import rospy
from std_msgs.msg import String

# Import the necessary components from the marine_acoustic_package
from marine_acoustic_msgs.msg import SonarImageData 

def build_SonarImageData(sonar_data):
    #sonar_data is the raw image data provided by sonoptix
    #TODO: check to see if there is anything else sent by sonar via RTSP

    #important: under 30 meters, it operates at 700khz, with a sector angle of 120 degrees
    #vertical view angle 20 degrees
    sonar_msg=SonarImageData()
    sonar_msg.dtype=0
    sonar_msg.beam_count=256
    #TODO: Transform this in a row major vector
    sonar_msg.data=sonar_data
    return sonar_msg
#------something for the commit---------
def publish_acoustic_data():
    # Initialize the ROS node
    rospy.init_node('sonar_publisher_node', anonymous=True)
    
    # Create a publisher that publishes String messages to the 'acoustic_data' topic
    pub = rospy.Publisher('/BlueRov2/sonar/image/data', SonarImageData, queue_size=10)
    
    # Set the loop rate
    rate = rospy.Rate(10)  # 10 Hz
    
    while not rospy.is_shutdown():
        # Get data from the acoustic API
        data = SonarImageData() #get the data here
        
        # Log the data being published
        rospy.loginfo(f"Publishing: {data}")
        
        # Publish the data
        pub.publish(data)
        
        # Sleep to maintain the loop rate
        rate.sleep()

if __name__ == '__main__':
    try:
        publish_acoustic_data()
    except rospy.ROSInterruptException:
        pass
