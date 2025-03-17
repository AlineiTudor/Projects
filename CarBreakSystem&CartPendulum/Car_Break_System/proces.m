function dx = proces(uv,x1,x2,x3,x4,x5,x6)

% max control curent 0.1 A
% min control curent 0.005 A
Kv=0.001 ;%valve input coef - uv is a current (A)
%inputs
Fext=0;%***************
u1=Kv*uv; 
u2=Fext;
%experimental friction parameters from Hydraulic servo systems Springer
sigma=200;%N s/m
Fc0=50;%N
Fs0=25;%N
cs=0.011;% m/s
%de Silva article
Mt=32.7;%kg
Vh=8.9*10^(-5);% m
A1=1.14*10^(-3);%m^2
A2=0.633*10^(-3);%m^2
Ap=(A1+A2)/2;
%Slidning mode control of hydraulic systems
Ps=300*10^5;%Pa
Pt=1*10^5;%Pa
% other sources
E=1.7*10^6;% Pa
%valve dynamics FitzSimons and Palazzolo
wv=730;%Hz natural frequency
Dv=0.4;%damping
Fhs=0;%ignore internal valve friction
cv1=6.6043*10^(-4);%m^2/(s sqrt(Pa)) valve discharge coefficients
cv2=cv1;
cv3=cv1;
cv4=cv1;
% piston length l=0.05 m +> xmax/xmin este +-0.025 m

Ff=sigma*x2+sign(x2)*(Fc0+Fs0*exp(-abs(x2)/cs));
%Ff=sigma*x2;% linear friction
%Ff=0;
qA=cv1*sg(x5)*sign(Ps-x3)*sqrt(abs(Ps-x3))-cv2*sg(-x5)*sign(x3-Pt)*sqrt(abs(x3-Pt));
qB=cv3*sg(-x5)*sign(Ps-x4)*sqrt(abs(Ps-x4))-cv4*sg(x5)*sign(x4-Pt)*sqrt(abs(x4-Pt));

dx1=x2;
dx2=((x3-x4)*Ap-Ff-u2)/Mt;
dx3=(qA-Ap*x2)*E/(Vh+Ap*x1);
dx4=(qB+Ap*x2)*E/(Vh-Ap*x1);
dx5=x6;
dx6=wv^2*(u1-2*Dv/wv*x6-x5-Fhs*sign(x5));

dx=[dx1 dx2 dx3 dx4 dx5 dx6];
end