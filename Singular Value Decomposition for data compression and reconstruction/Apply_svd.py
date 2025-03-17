from numpy import *
from scipy.linalg import svd

def svd_k_components(matrix,k=10):
    U,s,VT=svd(matrix)

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
    img_svdk=zeros(matrix.size)
    img_svdk=hstack(img_svdk)

    #check how to do this without using for
    for i in range (k):
        #print(Uk[:,i].size)
        #print(VkT[i,:].size)
        Ui=array(Uk[:,i])
        VkTi=array(VkT[i,:])
        #print(img_svdk.size)
        img_svdk=img_svdk+hstack(array(sk[i]*outer(Ui,VkTi)))

    img_svdk=img_svdk.reshape(matrix.shape)
    return img_svdk
