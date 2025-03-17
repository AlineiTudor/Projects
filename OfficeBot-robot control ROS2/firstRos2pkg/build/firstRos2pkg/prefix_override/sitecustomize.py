import sys
if sys.prefix == '/usr':
    sys.real_prefix = sys.prefix
    sys.prefix = sys.exec_prefix = '/home/tudor/colcon_ws/src/firstRos2pkg/install/firstRos2pkg'
