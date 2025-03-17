#!/usr/bin/python3

import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist
from std_msgs.msg import String  #check to see what kind of topic is the detection
from sensor_msgs.msg import LaserScan

from tf2_ros import TransformListener, Buffer
import math
import time

import threading


class FollowCharacter(Node):
    def __init__(self):
        super().__init__('follow_character')
        
        # Create a publisher for cmd_vel
        self.cmd_vel_publisher = self.create_publisher(Twist, '/cmd_vel', 10)
        
        # TF listener setup
        self.tf_buffer = Buffer()
        self.tf_listener = TransformListener(self.tf_buffer, self)
        

        # PID gains (these need to be tuned)
        self.kp_linear = 0.6
        self.ki_linear = 0.015
        self.kd_linear = 0.0
        
        self.kp_angular = 1.1
        self.ki_angular = 0.42
        self.kd_angular = 0.1
        
        self.integral_linear = 0.0
        self.integral_angular = 0.0
        
        # Previous errors for derivative calculation
        self.prev_error_linear = 0.0
        self.prev_error_angular = 0.0

        # Target distance to maintain from the character
        self.target_distance = 1.5  # meters
        # For the angle the setpoint is 0 and 
        # is redundant to substract 0 from my current measurement

        # Variables to track the time between detections
        self.prev_time = None

        # Subscribe to face detection topic
        self.face_subscriber = self.create_subscription(
            String, '/humans/persons/person_tudor/face_id', self.face_callback, 10
        )

        #subscribe to /scan topic 
        self.scan_subscriber=self.create_subscription(
            LaserScan,'/scan', self.scan_callback,10
        )
        self.object_between=False

        #retaining the faceID
        self.faceID="noID"


    def face_callback(self, msg):
        # Only process when the robot detects the specified face ID
        if msg.data:  # assuming msg.data contains the face ID when detected
            current_time = time.time()
            if not self.prev_time:
                dt = 0.1  # Initial assumption
            else:
                dt = current_time - self.prev_time  # Calculate time elapsed since last detection
                # Proceed with control calculations
                self.control_loop(dt,msg.data)

            self.prev_time = current_time
        else:
            stopcmd=Twist()
            self.cmd_vel_publisher.publish(stopcmd)

    def compute_line(self):
        now = rclpy.time.Time()
        map_person=self.tf_buffer.lookup_transform('map','person_tudor',now)
        map_base=self.tf_buffer.lookup_transform('map','base_link',now)
        xp=map_person.transform.translation.x
        yp=map_person.transform.translation.y
        xr=map_base.transform.translation.x
        yr=map_base.transform.translation.y
        #we compute the line's equations y=a*x+b -> we return a tuple (a,b)
        a=(yr-yp)/(xr-xp)
        b=yr-a*xr
        self.get_logger().info(f"Line's parameters (a,b): ({a},{b})")
        return (a,b)
    #the scan topic has ranges from right to left of the robot
    def scan_callback(self,scan_msg):
        try:
            now = rclpy.time.Time()
        
            ranges_of_interest=self.get_ranges_of_interest(scan_msg)

            trans = self.tf_buffer.lookup_transform('sellion_link', self.faceID, now)
            # Extract the position of the character relative to the robot
            x = trans.transform.translation.x
            y = trans.transform.translation.y

            # Calculate the distance and angle to the character
            distance = math.sqrt(x**2 + y**2)
            distance_treshold=0.3
            err_treshold=0.015
            character_torso_size=0.1847717817#the setpoint for the control algorithm is in the middle, while the laser scan hits the character in a near point on its body, which has this distance to the center line of the character
            is_obstacle=False
            for dist in ranges_of_interest:
                if abs(distance_treshold-dist)<=err_treshold:
                    self.avoid_objects()
                    is_obstacle=True
                    break
            if not is_obstacle:
                print("no obstacle towards human: reseting PIDs parameters")
                self.set_PID_coeff(0.6,0.015,0.0,1.1,0.42,0.1)
        except Exception as e:
            self.get_logger().warn(f"Could not get transform: {e}")
    def avoid_objects(self):
        print(f"objects are in the zone of interest, avoiding them...")
        self.set_PID_coeff()
        cmd=Twist()
        cmd.linear.x = 0.25
        cmd.angular.z = 0.25

        self.cmd_vel_publisher.publish(cmd)
        '''
        turning_angle=17#degrees
        no_turns=math.floor(math.pi/2*turning_angle/90)
        cmd.angular.z=turning_angle*pi/180/no_turns
        for i in range(no_turns):
            try:
                self.cmd_vel_publisher.publish(cmd)
                time.sleep(0.25)#so 4 times/second, kind of
            except Exception as e:
                self.get_logger().warn(f"Could not perform avoidance: {e}")
        '''

    def set_PID_coeff(self,kp_linear=0,ki_linear=0,kd_linear=0,kp_angular=0,ki_angular=0,kd_angular=0):
        self.kp_linear = kp_linear
        self.ki_linear = ki_linear
        self.kd_linear = kd_linear
        
        self.kp_angular = kp_angular
        self.ki_angular = ki_angular
        self.kd_angular = kd_angular

        self.integral_linear=0
        self.integral_angular=0
        
    def get_ranges_of_interest(self,scan_msg):
        range_list=scan_msg.ranges
        angle_of_interest=math.pi/4#can be adjusted if necessary
        angle_increment=scan_msg.angle_increment
        middle_of_list=math.floor(len(range_list)/2)
        first_index_interest=middle_of_list-math.floor(angle_of_interest/angle_increment)#right of robot
        last_index_interest=middle_of_list+math.floor(angle_of_interest/angle_increment)#left of robot
        return range_list[first_index_interest:last_index_interest+1]
        

    def control_loop(self, dt, faceID):
        try:
            self.compute_line()
            # Lookup the transform from the robot to the character frame
            now = rclpy.time.Time()
            face_frame="face_"+faceID
            self.faceID=face_frame
            trans = self.tf_buffer.lookup_transform('sellion_link', face_frame, now)
            
            # Extract the position of the character relative to the robot
            x = trans.transform.translation.x
            y = trans.transform.translation.y

            # Calculate the distance and angle to the character
            distance = math.sqrt(x**2 + y**2)
            angle_to_target = math.atan2(y, x)
            

            # PID control for linear velocity
            error_linear = distance - self.target_distance
            self.integral_linear += error_linear * dt  # Integrating over time

            # Derivative of the error
            derivative_linear = (error_linear - self.prev_error_linear) / dt

            # Compute the linear velocity
            linear_velocity = (
                (self.kp_linear * error_linear) + 
                (self.ki_linear * self.integral_linear) +
                (self.kd_linear * derivative_linear)
            )
            
            # Update the previous linear error for the next derivative calculation
            self.prev_error_linear = error_linear

            # PID control for angular velocity
            error_angular = angle_to_target
            self.integral_angular += error_angular * dt

            # Derivative of the error
            derivative_angular = (error_angular - self.prev_error_angular) / dt

            # Compute the angular velocity
            angular_velocity = (
                (self.kp_angular * error_angular) + 
                (self.ki_angular * self.integral_angular) +
                (self.kd_angular * derivative_angular)
            )
            
            # Update the previous angular error for the next derivative calculation
            self.prev_error_angular = error_angular

            # Create and publish the Twist message
            cmd = Twist()
            cmd.linear.x = linear_velocity
            cmd.angular.z = angular_velocity
            self.cmd_vel_publisher.publish(cmd)

            #self.get_logger().info(f"Distance: {distance}, Angle: {angle_to_target}, "
                                   #f"Linear Velocity: {linear_velocity}, Angular Velocity: {angular_velocity}")
        
        except Exception as e:
            self.get_logger().warn(f"Could not get transform: {e}")

def main(args=None):
    rclpy.init(args=args)
    follow_character = FollowCharacter()
    rclpy.spin(follow_character)
    follow_character.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
