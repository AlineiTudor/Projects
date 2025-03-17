clear
clc
x1=-120:0.1:120;
x2=-10:0.1:10;
[x1,x2]=meshgrid(x1,x2);
z=x1.^2.*x2.^2+113*x1.*x2-1;
figure
contour(x1,x2,z),hold on;
% figure
% mesh(x1,x2,z),hold on;

% syms x1 x2 real
% sol=solve(2*x1*x2^2+113*x2==0,2*x1^2*x2+113*x1==0)

H=[113^2/2 -113;-113 2];
eig(H);

g=4*x1+3*x2-1;
x1=-120:0.1:120;
x2=-10:0.1:10;
g=(1-3*x2)/4;%x1 is g
plot(g,x2,'r')

syms x1 x2 lam real
sol=solve(2*x1*x2^2+113*x2+4*lam==0,2*x1^2*x2+113*x1+3*lam==0,4*x1+3*x2-1==0)
x1_sol=[1/8 6.63 -6.38];
x2_sol=[1/6 -8.51 8.84];
H_L1=[2*x2_sol(1).^2 4*x1_sol(1).*x2_sol(1)+113 4;4*x1_sol(1).*x2_sol(1)+113 2*x1_sol(1).^2 3;4 3 0];
H_L2=[2*x2_sol(2).^2 4*x1_sol(2).*x2_sol(2)+113 4;4*x1_sol(2).*x2_sol(2)+113 2*x1_sol(2).^2 3;4 3 0];
H_L3=[2*x2_sol(3).^2 4*x1_sol(3).*x2_sol(3)+113 4;4*x1_sol(3).*x2_sol(3)+113 2*x1_sol(3).^2 3;4 3 0];

