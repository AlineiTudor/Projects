function [dx] = cont_pend_nelin(u,x)
M=0.5;
m=0.5;
b=0.1;
l=0.3;
I=0.006;
g=9.8;

x1=x(1);x2=x(2);x3=x(3);x4=x(4);

c1=M+m-m^2*l^2*cos(x3)^2/(I+m*l^2);
c2=-m*l/(I+m*l^2)*cos(x3)/(m+M-m^2*l^2/(I+m*l^2)*cos(x3)^2);

dx1=x2;
dx2=1/c1*(-b*x2+m^2*l^2*g/(I+m*l^2)*sin(2*x3)/2+m*l*x4^2*sin(x3)+u);
dx3=x4;
dx4=c2*(-b*x2+m^2*l^2*g/2/(I+m*l^2)*sin(2*x3)+m*l*x4^2*sin(x3)+u)-m*g*l/(I+m*l^2)*sin(x3);

dx=[dx1;dx2;dx3;dx4];
end

