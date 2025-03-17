%%
% figure
% mesh(x1,x2,f(x1,x2));
% 
% x0=[1;1];dfdx=[x0(2)+2*x0(1)*x0(2)^2+10*x0(1);x0(1)+2*x0(1)^2*x0(2)],d=-dfdx;x1=x0+0.07*d
% b=norm([x1(2)+2*x1(1)*x1(2)^2+10*x1(1);x1(1)+2*x1(1)^2*x1(2)])^2/norm([x0(2)+2*x0(1)*x0(2)^2+10*x0(1);x0(1)+2*x0(1)^2*x0(2)])^2;
% d=-[x1(2)+2*x1(1)*x1(2)^2+10*x1(1);x1(1)+2*x1(1)^2*x1(2)]+b*d;
% x0=x1;
% 
% 
% dfdx=[x0(2)+2*x0(1)*x0(2)^2+10*x0(1);x0(1)+2*x0(1)^2*x0(2)],d=-dfdx;x1=x0+0.07*d
% b=norm([x1(2)+2*x1(1)*x1(2)^2+10*x1(1);x1(1)+2*x1(1)^2*x1(2)])^2/norm([x0(2)+2*x0(1)*x0(2)^2+10*x0(1);x0(1)+2*x0(1)^2*x0(2)])^2;
% d=-[x1(2)+2*x1(1)*x1(2)^2+10*x1(1);x1(1)+2*x1(1)^2*x1(2)]+b*d;
%%
clear
clc

f=@(x1,x2)(x1.*x2+x1.^2.*x2.^2+5*x1.^2+1);

x1=-10:0.1:10;
x2=-100:0.1:10;
[x1,x2]=meshgrid(x1,x2);
figure
contour(x1,x2,f(x1,x2)),hold on;


x0=[-3;5];eps=1e-4;n_it_max=10000;
x_prev=x0;
dfdx=[x0(2)+2*x0(1)*x0(2)^2+10*x0(1);x0(1)+2*x0(1)^2*x0(2)];
d_c=-dfdx;
n_iter1=0;
%Fletcher-Reeves
while n_iter1<n_it_max
    
    n_iter1=n_iter1+1;
    
    func=@(s)f(x_prev(1)+s*d_c,x_prev(2)+s*d_c);
    s=mean(elim_gs(func,[0 20],eps*1e-2));
    
    x_c=x_prev+s*d_c;
    
    dfdx_p=[x_prev(2)+2*x_prev(1)*x_prev(2)^2+10*x_prev(1);x_prev(1)+2*x_prev(1)^2*x_prev(2)];
    dfdx_c=[x_c(2)+2*x_c(1)*x_c(2)^2+10*x_c(1);x_c(1)+2*x_c(1)^2*x_c(2)];
    
    b=norm(dfdx_c)^2/norm(dfdx_p)^2;
    d_c=-dfdx_c+b*d_c;
    
    if(norm(x_c-x_prev)<eps)
        break
    end
    x_prev=x_c;
end

%Polak-Ribiere
x_prev=x0;
dfdx=[x0(2)+2*x0(1)*x0(2)^2+10*x0(1);x0(1)+2*x0(1)^2*x0(2)];
d_c=-dfdx;
n_iter2=0;
while n_iter2<n_it_max
    
    n_iter2=n_iter2+1;
    
    func=@(s)f(x_prev(1)+s*d_c,x_prev(2)+s*d_c);
    s=mean(elim_gs(func,[-20 20],eps*1e-2));
    
    x_c2=x_prev+s*d_c;
    
    dfdx_p=[x_prev(2)+2*x_prev(1)*x_prev(2)^2+10*x_prev(1);x_prev(1)+2*x_prev(1)^2*x_prev(2)];
    dfdx_c=[x_c2(2)+2*x_c2(1)*x_c2(2)^2+10*x_c2(1);x_c2(1)+2*x_c2(1)^2*x_c2(2)];
    
    b=dfdx_c'*(dfdx_c-dfdx_p)/(dfdx_p'*dfdx_p);
    d_c=-dfdx_c+b*d_c;
    
    if(norm(x_c2-x_prev)<eps)
        break
    end
    x_prev=x_c2;
end

%Hestenes-Stiefel
x_prev=x0;
dfdx=[x0(2)+2*x0(1)*x0(2)^2+10*x0(1);x0(1)+2*x0(1)^2*x0(2)];
d_c=-dfdx;
n_iter3=0;
while n_iter3<n_it_max
    
    n_iter3=n_iter3+1;
    
    func=@(s)f(x_prev(1)+s*d_c,x_prev(2)+s*d_c);
    s=mean(elim_gs(func,[-20 20],eps*1e-2));
    
    x_c3=x_prev+s*d_c;
    
    dfdx_p=[x_prev(2)+2*x_prev(1)*x_prev(2)^2+10*x_prev(1);x_prev(1)+2*x_prev(1)^2*x_prev(2)];
    dfdx_c=[x_c3(2)+2*x_c3(1)*x_c3(2)^2+10*x_c3(1);x_c3(1)+2*x_c3(1)^2*x_c3(2)];
    
    b=dfdx_c'*(dfdx_c-dfdx_p)/(d_c'*(dfdx_c-dfdx_p));
    d_c=-dfdx_c+b*d_c;
    
    if(norm(x_c3-x_prev)<eps)
        break
    end
    x_prev=x_c3;
end
plot(x_c(1),x_c(2),'kx')
plot(x_c2(1),x_c2(2),'ro')
plot(x_c2(1),x_c3(2),'g*')
legend('Contour','Fletcher-Reeves','Polak-Ribiere','Hestenes-Stiefel')

figure
mesh(x1,x2,f(x1,x2))