clear 
clc
f=@(x1,x2)(x1.*x2+x1.^2.*x2.^2+5*x1.^2+1);

x1=-20:0.1:5;
x2=-20:0.1:5;
[x1,x2]=meshgrid(x1,x2);
figure
contour(x1,x2,f(x1,x2));
figure
mesh(x1,x2,f(x1,x2));

x0=[1;-4];
kmax=1000;
%% met Newton
k=0;eps=0.001;
x_p=x0;
while k<kmax
    dfdx=[x_p(2)+2*x_p(1)*x_p(2)^2+10*x_p(1);x_p(1)+2*x_p(1)^2*x_p(2)];
    H=[2*x_p(2)^2+10 1+4*x_p(1)*x_p(2);1+4*x_p(1)*x_p(2) 2*x_p(1)^2];
    x_c=x_p-H^-1*dfdx;
    
    if norm(x_c-x_p)<eps
        break
    end
    x_p=x_c;
    k=k+1;
end

%% met Levenberg-Marquardt
k=0;
x_p=x0;
lam=100;
I=eye(2);
while k<kmax
    dfdx=[x_p(2)+2*x_p(1)*x_p(2)^2+10*x_p(1);x_p(1)+2*x_p(1)^2*x_p(2)];
    H=[2*x_p(2)^2+10 1+4*x_p(1)*x_p(2);1+4*x_p(1)*x_p(2) 2*x_p(1)^2];
    x_c2=x_p-(lam*I+H)^-1*dfdx;
    if norm(x_c2-x_p)<eps
        break
    end
    x_p=x_c2;
    k=k+1;
end


%% Steepest descent
k=0;
x_p=x0;
interv_s=[0 10];
delta_s=eps*1e-3;
while k<kmax
    dfdx=[x_p(2)+2*x_p(1)*x_p(2)^2+10*x_p(1);x_p(1)+2*x_p(1)^2*x_p(2)];
    f_s=@(s)f(x_p(1)-s*dfdx(1),x_p(2)-s*dfdx(2))
    s=elim_gs(f_s,interv_s,delta_s)
  
    x_c3=x_p-s*dfdx/norm(dfdx);
    if norm(x_c3-x_p)<eps
        break
    end
    x_p=x_c3;
    k=k+1;
end
figure
contour(x1,x2,f(x1,x2)),hold on,plot(x_c(1),x_c(2),'r*')
plot(x_c2(1),x_c2(2),'kx'),plot(x_c3(1),x_c3(2),'bo')
legend('Contour','Newton','Levenberg-M.','Steepest descent');
    
    