#!/usr/bin/env python3

import sys
import rospy
from std_msgs.msg import Int32, Float32, String, Bool
from PyQt5.QtWidgets import QApplication, QMainWindow, QSlider, QVBoxLayout, QWidget, QLabel, QPushButton, QComboBox
from PyQt5.QtCore import Qt
from sonoptix_pkg.srv import SetConfig, SetConfigRequest


class ROSQtGUI(QMainWindow):

    def __init__(self, sonar_range=3, sonar_contrast="low", sonar_gain=0, sonar_palette="gray", sonar_isEnabled=False, sonar_stream_type=2):
        super().__init__()
        # ROS initialization
        self.range_publisher = rospy.Publisher('/range_slider', Int32, queue_size=10)
        self.contrast_publisher = rospy.Publisher('/contrast_slider', Float32, queue_size=10)
        self.gain_publisher=rospy.Publisher('/gain_slider', Int32, queue_size=10)
        self.palette_publisher=rospy.Publisher('/palette_slider', String, queue_size=10)
        self.pinging_publisher=rospy.Publisher('/pinging_button', Bool, queue_size=10)
        self.streamtype_publisher=rospy.Publisher('/streamtype_box',Int32, queue_size=10)
        rospy.init_node('sonoptix_gui_node',anonymous=True)
        self.config_service=rospy.ServiceProxy('set_config',SetConfig)

        # Initializing default values and intervals
        self.range_intervals=[3, 6, 9, 12, 15, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100, 125, 150, 175, 200]
        self.range_indexes=[i for i in range(len(self.range_intervals))]

        self.contrast_value=[0.6, 0.4, 0.2]
        self.contrast_name=["low", "normal", "high"]
        self.contrast_index=[i for i in range(len(self.contrast_value))]

        self.gain_intervals=[i for i in range(-20,25,5)]
        self.gain_indexes=[i for i in range(len(self.gain_intervals))]

        self.palette_value=["gray", "deep", "rainbow", "amber", "ironbow"]
        self.palette_index=[i for i in range(len(self.palette_value))]

        self.streamtype_list={0: "WebRTC", 2: "RTSP"}       

        self.init_sonar_range=sonar_range
        self.init_sonar_contrast=sonar_contrast
        self.init_sonar_gain=sonar_gain
        self.init_sonar_palette=sonar_palette
        self.init_sonar_isEnabled=sonar_isEnabled
        self.init_sonar_stream_type=sonar_stream_type
        self.init_sonar_stream_type=self.streamtype_list[sonar_stream_type]


        #Builfing GUI      
        self.setWindowTitle('Sonar Config')
        self.setGeometry(100, 100, 400, 300)

        self.central_widget = QWidget()
        self.setCentralWidget(self.central_widget)

        self.layout = QVBoxLayout(self.central_widget)

        # Create range slider
        self.range_slider = QSlider(Qt.Horizontal)
        self.range_slider.setRange(self.range_indexes[0],self.range_indexes[-1])
        self.range_slider.setTickPosition(QSlider.TicksBelow)
        self.range_slider.setTickInterval(1)
        self.range_slider.valueChanged.connect(self.range_slider_value_changed)
        self.range_label = QLabel(f'Range [m]: {self.init_sonar_range}')

        # Create contrast slider
        self.contrast_slider = QSlider(Qt.Horizontal)
        self.contrast_slider.setRange(self.contrast_index[0], self.contrast_index[-1])
        self.contrast_slider.setTickPosition(QSlider.TicksBelow)
        self.contrast_slider.setTickInterval(1)
        self.contrast_slider.valueChanged.connect(self.contrast_slider_value_changed)
        self.contrast_label = QLabel(f'Contrast: {self.init_sonar_contrast}')

        # Create gain slider
        self.gain_slider=QSlider(Qt.Horizontal)
        self.gain_slider.setRange(self.gain_indexes[0],self.gain_indexes[-1])
        self.gain_slider.setTickPosition(QSlider.TicksBelow)
        self.gain_slider.setTickInterval(1)
        self.gain_slider.valueChanged.connect(self.gain_slider_value_changed)
        self.gain_label = QLabel(f'Gain [db]: {self.init_sonar_gain}')

        # Create palette slider
        self.palette_slider=QSlider(Qt.Horizontal)
        self.palette_slider.setRange(self.palette_index[0],self.palette_index[-1])
        self.palette_slider.setTickPosition(QSlider.TicksBelow)
        self.palette_slider.setTickInterval(1)
        self.palette_slider.valueChanged.connect(self.palette_slider_value_changed)
        self.palette_label = QLabel(f'Palette: {self.init_sonar_palette}')

        #Create switch button for on/off pinging
        self.pinging_button=QPushButton(f"Enable ping: {self.init_sonar_isEnabled}")
        self.pinging_button.setCheckable(True)
        self.pinging_button.setChecked(self.init_sonar_isEnabled)
        self.pinging_button.toggled.connect(self.pinging_value_changed)

        #Create combobox to select streamtype
        self.streamtype_box=QComboBox()
        self.streamtype_box.addItems(self.streamtype_list.values())
        self.streamtype_box.setCurrentText(self.init_sonar_stream_type)
        self.streamtype_box.currentIndexChanged.connect(self.streamtype_box_changed)
        self.streamtype_box_label=QLabel("Streamtype: ")


        # Add widgets to the layout
        self.layout.addWidget(self.range_label)
        self.layout.addWidget(self.range_slider)
        self.layout.addWidget(self.contrast_label)
        self.layout.addWidget(self.contrast_slider)
        self.layout.addWidget(self.gain_label)
        self.layout.addWidget(self.gain_slider)
        self.layout.addWidget(self.palette_label)
        self.layout.addWidget(self.palette_slider)
        self.layout.addWidget(self.pinging_button)
        self.layout.addWidget(self.streamtype_box_label)
        self.layout.addWidget(self.streamtype_box)

        #Set sliders initial position, the rest are already initialized
        self.set_initial_sliders_positions()

        self.show()

    def set_widgets_initial_position(self):
        self.range_slider.setTickPosition()

    def range_slider_value_changed(self):
        value = self.range_slider.value()
        range=self.range_intervals[value]
        self.range_label.setText(f'Range [m]: {range}')
        self.range_publisher.publish(range)
        self.send_config_to_sonar()

    def contrast_slider_value_changed(self):
        value = self.contrast_slider.value()
        contrast_number=self.contrast_value[value]
        contrast_name=self.contrast_name[value]
        self.contrast_label.setText(f'Contrast: {contrast_name}')
        self.contrast_publisher.publish(contrast_number)
        self.send_config_to_sonar()

    def gain_slider_value_changed(self):
        value=self.gain_slider.value()
        gain=self.gain_intervals[value]
        self.gain_label.setText(f'Gain [db]: {gain}')
        self.gain_publisher.publish(gain)
        self.send_config_to_sonar()

    def palette_slider_value_changed(self):
        value=self.palette_slider.value()
        palette=self.palette_value[value]
        self.palette_label.setText(f'Palette: {palette}')
        self.palette_publisher.publish(palette)
        self.send_config_to_sonar()
    
    def pinging_value_changed(self):
        value=self.pinging_button.isChecked()
        self.pinging_button.setText(f"Enable ping: {value}")
        self.pinging_publisher.publish(value)
        self.send_config_to_sonar()

    def streamtype_box_changed(self):
        value=self.streamtype_box.currentText()
        streamtype_codes=list(self.streamtype_list.keys())
        code=streamtype_codes[list(self.streamtype_list.values()).index(value)]
        self.streamtype_publisher.publish(code)
        self.send_config_to_sonar()

    def set_initial_sliders_positions(self):
        self.range_slider.setValue(self.range_indexes[self.range_intervals.index(self.init_sonar_range)])
        self.contrast_slider.setValue(self.contrast_index[self.contrast_name.index(self.init_sonar_contrast)])
        self.gain_slider.setValue(self.gain_indexes[self.gain_intervals.index(self.init_sonar_gain)])
        self.palette_slider.setValue(self.palette_index[self.palette_value.index(self.init_sonar_palette)])

    def send_config_to_sonar(self):
        req=SetConfigRequest()
        req.range=self.range_intervals[self.range_slider.value()]
        req.contrast=self.contrast_value[self.contrast_slider.value()]
        req.gain=self.gain_intervals[self.gain_slider.value()]
        req.palette=self.palette_value[self.palette_slider.value()]
        req.pinging_enabled=self.pinging_button.isChecked()
        req.stream_type=list(self.streamtype_list.keys())[list(self.streamtype_list.values()).index(self.streamtype_box.currentText())]

        try:
            response=self.config_service(req)
            if response.success:
                rospy.loginfo("Sonar configuration updated successfully")
            else:
                rospy.logwarn("Failed to update sonar configuration")
        except Exception as e:
            rospy.logerr(f'Service call failed {e}')


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = ROSQtGUI(sonar_range=25,sonar_contrast="high",sonar_gain=-15,sonar_palette="deep",sonar_isEnabled=True,sonar_stream_type=2)
    sys.exit(app.exec_())
