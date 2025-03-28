#!/usr/bin/python3

import logging
officebots_logger = logging.getLogger("officebots")
import sys
import asyncio
import time
import base64

from officebots import Robot

from math import pi

import cv2
import numpy as np
from cv_bridge import CvBridge

import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist, PoseStamped, TransformStamped
from nav_msgs.msg import Odometry
from sensor_msgs.msg import LaserScan, Image
from hri_msgs.msg import IdsList, LiveSpeech
from std_msgs.msg import String, Float32

import random

from tf2_ros import TransformException
from tf2_ros.buffer import Buffer
from tf2_ros.transform_listener import TransformListener
from tf2_ros.transform_broadcaster import TransformBroadcaster
from pytransform3d import rotations as pt

OPTICAL_FRAME_ROTATION = pt.quaternion_from_euler([-pi / 2.0, 0.0, -pi / 2], 0.0, 1.0, 2.0, True)

#argv = rospy.myargv(argv=sys.argv)
#
#if len(argv) < 2:
#    print("Usage: %s <robot name>" % argv[0])
#    sys.exit(1)

robot_name = "HRI"


def random_id():
    return "".join(random.choices("abcdefghijklmnopqrstuvxyz", k=5))

def restore_logging():
    handler = logging.StreamHandler()
    handler.setFormatter(
        logging.Formatter("[%(levelname)s] %(asctime)s - %(name)s: %(message)s")
    )
    officebots_logger.addHandler(handler)
    officebots_logger.setLevel(logging.INFO)

async def spin_async(executor: rclpy.executors.SingleThreadedExecutor):
    while rclpy.ok():
        executor.spin_once(timeout_sec=0)
        await asyncio.sleep(0)

class RosOfficeBots(Robot):
    base_frame = "base_link"
    sellion_frame = "sellion_link"

    def __init__(self):
        super().__init__()
        restore_logging()
        self.rosnode = Node('officebots_ros2_bridge')
        self.executor = rclpy.executors.SingleThreadedExecutor()
        self.executor.add_node(self.rosnode)
        self.spin_task = spin_async(self.executor)

        self.rosnode.create_subscription(Twist, 'cmd_vel', self.on_cmd_vel, 1)
        self.rosnode.create_subscription(PoseStamped, 'move_base_simple/goal', self.on_nav_goal, 1)
        self.rosnode.create_subscription(Image, 'screen/raw_image', self.on_screen_image, 1)
        self.rosnode.create_subscription(String, 'say', self.on_say, 1)

        self.supports_camera = True  # will be automatically set to false if the game reports no camera support

        self.cv_bridge = CvBridge()
        self.br = TransformBroadcaster(self.rosnode)

        self.odom_pub = self.rosnode.create_publisher(Odometry, 'odom', 1)
        self.odom_msg = Odometry()
        self.odom_msg.header.frame_id = "odom"
        self.odom_msg.child_frame_id = self.base_frame
        self.odom_msg.pose.pose.position.z = 0.0
        self.odom_msg.pose.pose.orientation.x = 0.0
        self.odom_msg.pose.pose.orientation.y = 0.0

        # laser scan parameters

        nb_rays = 50
        self.angle_increment = pi / (nb_rays - 1)
        self.angle_min = -pi / 2
        self.angle_max = pi / 2
        self.range_min = 0.0  # m
        self.range_max = 20.0  # m

        self.scan_pub = self.rosnode.create_publisher(LaserScan, 'scan', 1)
        self.scan_msg = LaserScan()
        self.scan_msg.header.frame_id = self.base_frame
        self.scan_msg.angle_min = self.angle_min
        self.scan_msg.angle_max = self.angle_max
        self.scan_msg.angle_increment = self.angle_increment
        self.scan_msg.time_increment = 0.0
        self.scan_msg.range_min = self.range_min
        self.scan_msg.range_max = self.range_max

        self.image_pub = self.rosnode.create_publisher(Image, 'camera/rgb/image_raw', 1)

        self.last = time.time()

        self.humans = {}
        self.face_tracked_pub = self.rosnode.create_publisher(IdsList, f"/humans/faces/tracked", 1)
        self.body_tracked_pub = self.rosnode.create_publisher(IdsList, f"/humans/bodies/tracked",1 )
        self.voices_tracked_pub = self.rosnode.create_publisher(IdsList, f"/humans/voices/tracked", 1)
        self.person_tracked_pub = self.rosnode.create_publisher(IdsList, f"/humans/persons/tracked", 1)
        self.person_known_pub = self.rosnode.create_publisher(IdsList, f"/humans/persons/known", 1)

        self.voices = {}
        self.rosnode.get_logger().info('Initialized publishers and subscribers')

    def safe_name(self, name):
        for c in " -,.'\";+_":
            name = name.replace(c, "")
        return name.lower()

    def add_human(self, name):
        # person_id = "person_" + random_id()
        person_id = "person_" + self.safe_name(name)

        face_id_pub = self.rosnode.create_publisher(String, f"/humans/persons/{person_id}/face_id", 1)
        body_id_pub = self.rosnode.create_publisher(String, f"/humans/persons/{person_id}/body_id", 1)
        voice_id_pub = self.rosnode.create_publisher(String, f"/humans/persons/{person_id}/voice_id", 1)
        name_pub = self.rosnode.create_publisher(String, f"/humans/persons/{person_id}/name", 1)

        self.humans[name] = {
            "id": person_id,
            "visible": False,
            "face_id_pub": face_id_pub,
            "body_id_pub": body_id_pub,
            "voice_id_pub": voice_id_pub,
            "name_pub": name_pub,
        }

        return person_id

    def add_voice(self):
        voice_id = random_id()

        speech_pub = self.rosnode.create_publisher(LiveSpeech, f"/humans/voices/{voice_id}/speech", 1)

        self.voices[voice_id] = {"speech_pub": speech_pub}

        return voice_id

    def remove_human(self, name):
        if name not in self.humans:
            return

        p = self.humans[name]

        # unregister all ROS publishers
        for _, v in p:
            if hasattr(v, "unregister"):
                v.unregister()

        del self.humans[name]

    def update_humans(self, seen_humans):

        if seen_humans is not None:
            seen = {p[0]: p[1:] for p in seen_humans}

            for name in seen.keys():
                if name not in self.humans:
                    self.add_human(name)

                # the human is either new or just re-appeared
                if not self.humans[name]["visible"]:
                    self.humans[name]["visible"] = True
                    face_id = random_id()
                    self.humans[name]["face"] = face_id

                self.humans[name]["pos"] = seen[name][0:3]
                self.humans[name]["face_transform"] = seen[name][3:9]

            not_visible_anymore = []

            for name in self.humans.keys():
                if name not in seen.keys():
                    not_visible_anymore.append(name)

            for name in not_visible_anymore:
                self.humans[name]["visible"] = False
                self.humans[name]["face"] = ""
                self.humans[name]["gaze"] = ""
                self.humans[name]["body"] = ""

    def publish_humans(self):

        faces_list = IdsList()
        bodies_list = IdsList()
        voices_list = IdsList()
        tracked_persons_list = IdsList()
        known_persons_list = IdsList()

        for name, p in self.humans.items():

            known_persons_list.ids.append(p["id"])

            if "pos" in p:
                x, y, theta = p["pos"]

                # for 'known' persons (even if not currently visible), always
                # publish the map <-> person transform
                qw, qx, qy, qz = pt.quaternion_from_euler([0, 0, theta], 0,1,2,True)

                trs = TransformStamped()
                trs.header.stamp = self.rosnode.get_clock().now().to_msg()
                trs.header.frame_id = "map"
                trs.child_frame_id = p["id"]
                trs.transform.rotation.x = qx
                trs.transform.rotation.y = qy
                trs.transform.rotation.z = qz
                trs.transform.rotation.w = qw
                trs.transform.translation.x = x
                trs.transform.translation.y = y
                trs.transform.translation.z = 0.0

                self.br.sendTransform(trs)

            if p["visible"]:
                tracked_persons_list.ids.append(p["id"])

            msg = String()
            if "face" in p and p["face"] != "":
                faces_list.ids.append(p["face"])
                msg.data = p["face"]

                x, y, z, rx, ry, rz = p["face_transform"]
                # publish the 'face' and 'gaze' tf frames
                qw, qx, qy, qz = pt.quaternion_from_euler([rx, ry, rz], 0,1,2,True)

                trs = TransformStamped()
                trs.header.stamp = self.rosnode.get_clock().now().to_msg()
                trs.header.frame_id = "map"
                trs.child_frame_id = "face_" + p["face"]
                trs.transform.rotation.x = qx
                trs.transform.rotation.y = qy
                trs.transform.rotation.z = qz
                trs.transform.rotation.w = qw
                trs.transform.translation.x = x
                trs.transform.translation.y = y
                trs.transform.translation.z = z

                self.br.sendTransform(trs)
                # gaze follows the optical frame convention: z-forward

                trs = TransformStamped()
                trs.header.stamp = self.rosnode.get_clock().now().to_msg()
                trs.header.frame_id = "face_" + p["face"]
                trs.child_frame_id = "gaze_" + p["face"]
                trs.transform.rotation.x = OPTICAL_FRAME_ROTATION[1]
                trs.transform.rotation.y = OPTICAL_FRAME_ROTATION[2]
                trs.transform.rotation.z = OPTICAL_FRAME_ROTATION[3]
                trs.transform.rotation.w = OPTICAL_FRAME_ROTATION[0]
                trs.transform.translation.x = 0.0
                trs.transform.translation.y = 0.0
                trs.transform.translation.z = 0.0

                self.br.sendTransform(trs)

            # else, no face -> publish empty face id
            p["face_id_pub"].publish(msg)

            msg = String()
            if "body" in p and p["body"] != "":
                bodies_list.ids.append(p["body"])
                msg.data = p["body"]
            # else, no body -> publish empty body id
            p["body_id_pub"].publish(msg)

            msg = String()
            if "voice" in p and p["voice"] != "":
                voices_list.ids.append(p["voice"])
                msg.data = p["voice"]
            # else, no voice -> publish empty voice id
            p["voice_id_pub"].publish(msg)

            msg = String()
            msg.data = name
            p["name_pub"].publish(msg)

        self.face_tracked_pub.publish(faces_list)
        self.body_tracked_pub.publish(bodies_list)
        self.voices_tracked_pub.publish(voices_list)
        self.person_tracked_pub.publish(tracked_persons_list)
        self.person_known_pub.publish(known_persons_list)

    async def run(self):
        self._event_loop.create_task(self.spin_task)
        self.rosnode.get_logger().info("ROS Officebots bridge is starting")
        res = await self.execute([robot_name, "create"])
        if res[0] != self.OK:
            self.rosnode.get_logger().warning(res[1])
        else:
            self.rosnode.get_logger().info(f"Created the robot {robot_name}")

        self.rosnode.get_logger().info("ROS Officebots bridge ready")


        # simply keeps python from exiting until this node is stopped
        while rclpy.ok():
            if self.supports_camera:
                status, jpg_data = await self.execute([robot_name, "export-camera"])
                if status == Robot.OK:
                    # await asyncio.sleep(0.1)
                    array = np.asarray(bytearray(jpg_data), dtype=np.uint8)
                    image = cv2.imdecode(array, cv2.IMREAD_COLOR)
                    image_msg = self.cv_bridge.cv2_to_imgmsg(
                        image, encoding="passthrough"
                    )
                    self.get_logger().warning("publishing image")
                    self.image_pub.publish(image_msg)
                else:
                    if "Unknown command" in jpg_data:
                        self.supports_camera = False

            status, humans = await self.execute([robot_name, "get-humans"])
            if status == Robot.OK:
                self.update_humans(humans)

        self.stop()
        self.rosnode.get_logger().info("Bye!")

    async def on_robot_update(self, data):

        now = time.time()
        dt = now - self.last
        self.last = now

        x, y, theta, v, w = data["odom"]

        qw, qx, qy, qz = pt.quaternion_from_euler([0, 0, theta], 0,1,2,True)

        self.odom_msg.header.stamp = self.rosnode.get_clock().now().to_msg()
        self.odom_msg.pose.pose.position.x = x
        self.odom_msg.pose.pose.position.y = y

        self.odom_msg.pose.pose.orientation.z = qz
        self.odom_msg.pose.pose.orientation.w = qw

        self.odom_msg.twist.twist.linear.x = float(v)
        self.odom_msg.twist.twist.angular.z = float(w)

        self.odom_pub.publish(self.odom_msg)

        # TODO This is a static transform, so it should be published as such
        trs = TransformStamped()
        trs.header.stamp = self.rosnode.get_clock().now().to_msg()
        trs.header.frame_id = "map"
        trs.child_frame_id = "odom"
        trs.transform.rotation.x = 0.0
        trs.transform.rotation.y = 0.0
        trs.transform.rotation.z = 0.0
        trs.transform.rotation.w = 1.0
        trs.transform.translation.x = 0.0
        trs.transform.translation.y = 0.0
        trs.transform.translation.z = 0.0

        self.br.sendTransform(trs)

        trs = TransformStamped()
        trs.header.stamp = self.rosnode.get_clock().now().to_msg()
        trs.header.frame_id = "odom"
        trs.child_frame_id = self.base_frame
        trs.transform.rotation.x = qx
        trs.transform.rotation.y = qy
        trs.transform.rotation.z = qz
        trs.transform.rotation.w = qw
        trs.transform.translation.x = x
        trs.transform.translation.y = y
        trs.transform.translation.z = 0.0

        self.br.sendTransform(trs)

        trs = TransformStamped()
        trs.header.stamp = self.rosnode.get_clock().now().to_msg()
        trs.header.frame_id= self.base_frame
        trs.child_frame_id = self.sellion_frame
        trs.transform.rotation.x = 0.0
        trs.transform.rotation.y = 0.0
        trs.transform.rotation.z = 0.0
        trs.transform.rotation.w = 1.0
        trs.transform.translation.x = 0.0
        trs.transform.translation.y = 0.0
        trs.transform.translation.z = 1.6

        self.br.sendTransform(trs)

        self.scan_msg.scan_time = dt
        self.scan_msg.ranges =[float(i) for i in data["laserscan"]]
        self.scan_msg.header.stamp = self.rosnode.get_clock().now().to_msg()

        self.scan_pub.publish(self.scan_msg)

        speech = data["speech_heard"]
        if speech:
            text, name = speech

            if name not in self.humans:
                self.add_human(name)

            if "voice" not in self.humans[name] or (not self.humans[name]["voice"]):

                voice_id = self.add_voice()
                self.humans[name]["voice"] = voice_id

            voice_id = self.humans[name]["voice"]
            speech_msg = LiveSpeech()
            speech_msg.final = text
            speech_msg.confidence = 1.0
            self.voices[voice_id]["speech_pub"].publish(speech_msg)

        self.publish_humans()

    def on_cmd_vel(self, twist):
        x = twist.linear.x
        w = twist.angular.z

        self.rosnode.get_logger().info("Sending velocity commands to the robot")
        self._event_loop.create_task(self.execute([robot_name, "cmd-vel", [x, w]]))

    def on_nav_goal(self, pose):
        self.rosnode.get_logger().info("Sending navigation goal command to the robot")
        if pose.header.frame_id != "map":
            self.rosnode.get_logger().warning("The navigation goal PoseStamped must currently be set in the 'map' reference frame")
            return

        x = pose.pose.position.x
        y = pose.pose.position.y

        self._event_loop.create_task(self.execute([robot_name, "navigate-to", [x, y]]))

    def on_screen_image(self, image):

        cv_img = self.cv_bridge.imgmsg_to_cv2(image, desired_encoding="passthrough")

        cv_img = cv2.resize(cv_img, (320, 240))
        _, buf = cv2.imencode(".jpg", cv_img)
        b64 = base64.b64encode(buf).decode("ascii")
        self.rosnode.get_logger().debug("Sending image size: %skb" % (len(b64) / 1024))

        self._event_loop.create_task(self.execute([robot_name, "set-screen", [b64]]))

    def on_say(self, msg):

        self.rosnode.get_logger().info("Making the robot talk")
        self._event_loop.create_task(self.execute([robot_name, "say", [msg.data]]))

#class OfficeBotsBridge(Node):
#    def __init__(self):
#        super().__init__('officebots_ros2_bridge')
#        #rclpy.init(args=sys.argv)
#        RosOfficeBots().start()
#
#def main(args=None):
#    rclpy.init(args=args)
#    officebots = OfficeBotsBridge()
#    rclpy.spin(officebots)
#
#    officebots.destroy_node()
#    rclpy.shutdown

def main(args=None):
    rclpy.init(args=args)
    RosOfficeBots().start()

if __name__ == "__main__":
    RosOfficeBots().start()
