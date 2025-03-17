% liniarizare simbolica
clear all
clc

%variables
x1=sym('x1','real');
x2=sym('x2','real');
x3=sym('x3','real');
x4=sym('x4','real');
x5=sym('x5','real');
x6=sym('x6','real');
uv=sym('uv','real');


% parameters

% max control curent 0.1 A
% min control curent 0.005 A
Kv=0.001 ;%valve input coef - uv is a current (A)
%inputs
Fext=0;
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


Ff=sigma*x2;%+sign(x2)*(Fc0+Fs0*exp(-abs(x2)/cs));
%Ff=sigma*x2;% linear friction

%qA=cv1*sg(x5)*sign(Ps-x3)*sqrt(abs(Ps-x3))-cv2*sg(-x5)*sign(x3-Pt)*sqrt(abs(x3-Pt));
qA=cv1*x5*sqrt(abs(Ps-x3))-cv2*(-x5)*sqrt(abs(x3-Pt));
%qB=cv3*sg(-x5)*sign(Ps-x4)*sqrt(abs(Ps-x4))-cv4*sg(x5)*sign(x4-Pt)*sqrt(abs(x4-Pt));
qB=cv3*(-x5)*sqrt(abs(Ps-x4))-cv4*(x5)*sqrt(abs(x4-Pt));

dx1=x2;
dx2=((x3-x4)*Ap-Ff-u2)/Mt;
dx3=(qA-Ap*x2)*E/(Vh+Ap*x1);
dx4=(qB+Ap*x2)*E/(Vh-Ap*x1);
dx5=x6;
%dx6=wv^2*(u1-2*Dv/wv*x6-x5-Fhs*sign(x5));
dx6=wv^2*(u1-2*Dv/wv*x6-x5);

x=[x1 x2 x3 x4 x5 x6]';

F=[dx1 dx2 dx3 dx4 dx5 dx6]';

A=jacobian(F,x);
B=jacobian(F,uv);
x1=0;x2=0;x3=150e5;x4=150e5;x5=0;x6=0;uv=0;
A=eval(A);
A=vpa(A,2)
B=eval(B);
B=vpa(B,2);
rank(A);

Co=[B A*B A^2*B A^3*B A^4*B A^5*B];
%Co2=ctrb(A,B);

Ar=[0 A(1,2) 0 0 0;0 A(2,2) A(2,3) 0 0;0 2*A(3,2) 0 2*A(3,5) 0;0 0 0 0 A(5,6);0 0 0 A(6,5) A(6,6)];
Br=[0;0;0;0;B(6,1)];
Cor=[Br Ar*Br Ar^2*Br Ar^3*Br Ar^4*Br];
rank(Cor)
Ar=eval(Ar);
Br=eval(Br);
K=place(Ar,Br,[-99  -100  -101  -200  -201]);
C=[1 0 0 0 0];
N=-inv(C*inv(Ar-Br*K)*Br)

%%
%Observability
C=[1 0 0 0 0]
Ob=obsv(Ar,C);
rank(Ob)%este 5
%L=place(Ar',C',[-495 -500 -505 -1000 -1005]);
%L=place(Ar',C',[-495 -500 -505 -1000 -1005]/2.5);
L=place(Ar',C',[-1000  -2000  -3000  -3500  -4000]);

L=L';
