clear 
clc
V1=[0,2,3]';
V2=[1,3,8]';
V3=[3,7,5]';
V4=[6,2,10]';
A=[V1,V2,V3,V1,V4,V2,V3,V4]
% A=[V1';V2';V3';V4']
% piramida1=alphaShape(A(:,1),A(:,2),A(:,3))
a=figure(1)
plot3(A(1,:),A(2,:),A(3,:)),hold on
V1=[0,2,3]'+1;
V2=[1,3,8]'+2;
V3=[3,7,5]'+1;
V4=[6,2,10]'+2;
A=[V1,V2,V3,V1,V4,V2,V3,V4]
plot3(A(1,:),A(2,:),A(3,:))
% A=[V1';V2';V3';V4']
% piramida2=alphaShape(A(:,1),A(:,2),A(:,3))
% plot(piramida1),hold on,plot(piramida2)

%V1,v2,v3,v1,v4,v2,v3,v4
figure(a)

