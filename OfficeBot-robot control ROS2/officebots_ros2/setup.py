from setuptools import find_packages, setup

package_name = 'officebots_ros2'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='nakano',
    maintainer_email='891234ser@eipieq.com',
    description='TODO: Package description',
    license='MIT',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'officebots_ros2_bridge = officebots_ros2.officebots_ros2_bridge:main'
        ],
    },
)
