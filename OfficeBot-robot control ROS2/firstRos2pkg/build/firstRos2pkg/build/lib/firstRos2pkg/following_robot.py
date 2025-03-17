#!/usr/bin/python3

import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist
from std_msgs.msg import String  #check to see what kind of topic is the detection

from tf2_ros import TransformListener, Buffer
import math
import time

class FollowCharacter(Node):
    def __init__(self):
        super().__init__('follow_character')
        
        # Create a publisher for cmd_vel
        self.cmd_vel_publisher = self.create_publisher(Twist, '/cmd_vel', 10)
        
        # TF listener setup
        self.tf_buffer = Buffer()
        self.tf_listener = TransformListener(self.tf_buffer, self)
        
        # PID gains (these need to be tuned)
        self.kp_linear = 1.0
        self.ki_linear = 0.1
        self.kd_linear = 0.05
        
        self.kp_angular = 2.0
        self.ki_angular = 0.0
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

                

    def control_loop(self, dt, faceID):
        try:
            # Lookup the transform from the robot to the character frame
            now = rclpy.time.Time()
            face_frame="face_"+faceID
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

            self.get_logger().info(f"Distance: {distance}, Angle: {angle_to_target}, "
                                   f"Linear Velocity: {linear_velocity}, Angular Velocity: {angular_velocity}")
        
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
