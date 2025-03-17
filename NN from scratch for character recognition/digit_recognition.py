from Network import *
import sys
sys.path.append('C:\\Master\An1\\sem1\\Machine learning\\Number recognition\\neural-networks-and-deep-learning-master\\src')
import mnist_loader

training_data,validation_data,test_data=mnist_loader.load_data_wrapper()


net=Network([784,30,10])
net.SGD(training_data,90,100,2,test_data=test_data)