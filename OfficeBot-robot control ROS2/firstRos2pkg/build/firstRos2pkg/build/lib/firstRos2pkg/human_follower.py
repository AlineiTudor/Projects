import rclpy
from rclpy.node import Node

from std_msgs.msg import String


class MinimalPublisher(Node):

    def __init__(self):
        super().__init__('minimal_publisher')
        self.publisher_ = self.create_publisher(String, 'topic', 10)
        timer_period = 0.5  # seconds
        self.timer = self.create_timer(timer_period, self.timer_callback)
        self.i = 0

    def timer_callback(self):
        msg = String()
        msg.data = 'Hello World: %d' % self.i
        self.publisher_.publish(msg)
        self.get_logger().info('Publishing: "%s"' % msg.data)
        self.i += 1


def main(args=None):
    rclpy.init(args=args)

    minimal_publisher = MinimalPublisher()

    rclpy.spin(minimal_publisher)

    # Destroy the node explicitly
    # (optional - otherwise it will be done automatically
    # when the garbage collector destroys the node object)
    minimal_publisher.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()

##################subscriber ROS2
import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist
from std_msgs.msg import String
from tf2_msgs.msg import TFMessage
from hri_msgs.msg import IdsList
import tf2_ros as tf2
from tf2_ros.buffer import Buffer


class MinimalSubscriber(Node):

    def __init__(self):
        super().__init__('creepy_follower')

        import tf2_ros
        from tf2_geometry_msgs import do_transform_point
        from geometry_msgs.msg import Point

        tf_buffer = tf2_ros.Buffer(rospy.Duration(tf_cache_duration))
        tf2_ros.TransformListener(tf_buffer)

        self.publisher = self.create_publisher(Twist, '/cmd_vel', 10)
        timer_period=0.5
        self.timer = self.create_timer(timer_period, self.send_follow_command)
        self.tf_buffer = Buffer()

        self.subscription  # prevent unused variable warning

    def get_target(self, msg):
        transform=self.tf_buffer.lookup_transform
        cmd=Twist()
        self.publisher.publish(cmd)

    def send_follow_command(self,msg):
        pass


def main(args=None):
    rclpy.init(args=args)

    minimal_subscriber = MinimalSubscriber()

    rclpy.spin(minimal_subscriber)

    # Destroy the node explicitly
    # (optional - otherwise it will be done automatically
    # when the garbage collector destroys the node object)
    minimal_subscriber.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()