#-------computing SVD for simple matrix--------------
from numpy import *
from scipy.linalg import svd
##define matrix A mxn, U mxm,S mxn, VT nxn
A = array([[1, 2], [3, 4], [5, 6]])
#print(A)
##SVD
U,S,VT=svd(A)
#print(U)
#print(S)
#print(VT)

##Reconstructing A
##for this we need to make S a mxn "diagonal matrix": sigma has a diagonal matrix of nxn elements
sigma=zeros((A.shape[0],A.shape[1]))
sigma[:A.shape[1],:A.shape[1]]=diag(S)
A_reconstruct=U.dot(sigma.dot(VT))

#print(A_reconstruct)

#------------showing matrix as image--------------
from matplotlib import pyplot as plt
"""
plt.figure(1)
plt.subplot(121)
plt.imshow(A)
plt.subplot(122)
plt.imshow(A_reconstruct)
plt.show()
"""

#coloanele lui U sunt left-singular vectors of A
#coloanele lui V (nu VT= V transpose) sunt right singular vectors of A

#----------svd for grayscale image-----------------
from PIL import Image
img=Image.open("C:\Master\An1\sem1\Machine learning\RGB image.jfif")

img_gray=img.convert('L')

#convert PIL image to matrix
img=asarray(img)
img_gray=asarray(img_gray)
#print(img_gray)

plt.figure(1)
plt.subplot(411)
plt.imshow(img)
plt.subplot(412)
plt.imshow(img_gray,cmap = plt.cm.gray)


U,s,VT=svd(img_gray)
#print(img_gray.shape)

#keep in mind A=U*Sigma*V^T~s1*U1*V1^T+...+sk*Uk*Vk^T
#where si= the i-st greatest element of all the singular values and 
#and Ui and Vi the corespondin left and right singular vectors

k=1#number of first singular values to approximate A with a k rank matrix
#getting indexes for sorted singular values
s_sort_ind=argsort(s)[::-1]
s_sorted=s[s_sort_ind]
#getting coresponding vectors
U_sort=U[:,s_sort_ind]
V=transpose(VT)
V_sort=V[:,s_sort_ind]

sk=s_sorted[0:k]
Uk=array(U_sort[:,0:k])
Vk=V_sort[:,0:k]
VkT=transpose(Vk)

#print(array(vstack(Uk)).size)
#print(array(vstack(VkT)).size)
img_svdk=zeros(img_gray.size)
img_svdk=hstack(img_svdk)

#check how to do this without iterations
for i in range (k):
    #print(Uk[:,i].size)
    #print(VkT[i,:].size)
    Ui=array(Uk[:,i])
    VkTi=array(VkT[i,:])
    #print(img_svdk.size)
    img_svdk=img_svdk+hstack(array(sk[i]*outer(Ui,VkTi)))

img_svdk=img_svdk.reshape(img_gray.shape)
plt.subplot(4,1,3)
plt.imshow(img_svdk,cmap = plt.cm.gray)


#-----------svd for rgb image----------------------
from Apply_svd import *

#k=int(floor(len(img[:,:,0])/10))
#k=50#k is taken from above
R=img[:,:,0]
G=img[:,:,1]
B=img[:,:,2]

R_svdk=svd_k_components(R,k)
G_svdk=svd_k_components(G,k)
B_svdk=svd_k_components(B,k)


img_rgb_svdk=zeros(img.shape)
img_rgb_svdk[:,:,0]=R_svdk
img_rgb_svdk[:,:,1]=G_svdk
img_rgb_svdk[:,:,2]=B_svdk
print(img_rgb_svdk)
print(img)

plt.subplot(4,1,4)
plt.imshow(img_rgb_svdk.astype('uint8'))#!!!!!!!!!!!!!!
plt.show()

