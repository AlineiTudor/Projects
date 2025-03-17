from setuptools import find_packages, setup

package_name = 'firstRos2pkg'

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
    maintainer='tudor',
    maintainer_email='tudor0008@gmail.com',
    description='TODO: Package description',
    license='Apache-2.0',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'human_follower = firstRos2pkg.human_follower:main',
            'follow_character = firstRos2pkg.following_robot:main'
        ],
    },
)
