%f(x1,x2)=x1*x2+x1^2*x2^2+5*x1^2+1
clear
close
clc

x1=-5:0.1:5;
x2=-10:0.1:10;
% x1=-1e9:1e8:2e9;
% x2=-1e9:1e8:2e9;
[x1,x2]=meshgrid(x1,x2);
f=@(x1,x2)(x1.*x2+x1.^2.*x2.^2+5.*x1.^2+1);
jacob=@(x1,x2)([x2+2*x1.*x2.^2+10*x1;x1+2*x1.^2*x2]);


figure
mesh(x1,x2,f(x1,x2));
figure
contour(x1,x2,f(x1,x2)),hold on,

x0=[-4;4];
eps=1e-2;
n_iter_max=1000;

[points_DFP,n_it_DFP]=DFP_quasi_New(f,jacob,x0,eps,n_iter_max);
[points_BFGS,n_it_BFGS]=BFGS_quasi_New(f,jacob,x0,eps,n_iter_max);

plot(points_DFP(1,:),points_DFP(2,:),'ro')
plot(points_BFGS(1,:),points_BFGS(2,:),'gx')
xlabel('x_1'),ylabel('x_2'),legend('contour','DFP','BFGS');


function [points,iter]=DFP_quasi_New(func,jacobi,x0,eps,n_iter_max)
    iter=0;
    B=eye(length(x0));
    points=x0;
    while iter<n_iter_max
        iter=iter+1;
        
        %comp direction
        d=-B*jacobi(points(1,iter),points(2,iter));
        
        %optimize step size
        f=@(s)func(points(1,iter)+s*d(1),points(2,iter)+s*d(2));
        s=mean(elim_gs(f,[0 2000],eps*1e-2));
        
        %comp new point
        points=[points,points(:,iter)+s*d];
        
        %comp difference: for x and gradient
        dx=points(:,iter+1)-points(:,iter);
        dG=jacobi(points(1,iter+1),points(2,iter+1))-jacobi(points(1,iter),points(2,iter));
        
        B=B+dx*dx'/(dx'*dG)-B*dG*(B*dG)'/(dG'*B*dG);
        
        if norm(points(:,iter+1)-points(:,iter))<eps
            break;
        end
    end
    func(points(1,iter+1),points(2,iter+1))
end

function [points,iter]=BFGS_quasi_New(func,jacobi,x0,eps,n_iter_max)
    iter=0;
    B=eye(length(x0));
    points=x0;
    while iter<n_iter_max
        iter=iter+1;
        
        %comp direction
        d=-B*jacobi(points(1,iter),points(2,iter));
        
        %optimize step size
        f=@(s)func(points(1,iter)+s*d(1),points(2,iter)+s*d(2));
        s=mean(elim_gs(f,[0 2000],eps*1e-2));
        
        %comp new point
        points=[points,points(:,iter)+s*d];
        
        %comp difference: for x and gradient
        dx=points(:,iter+1)-points(:,iter);
        dG=jacobi(points(1,iter+1),points(2,iter+1))-jacobi(points(1,iter),points(2,iter));
        
        B=B+dG*dG'/(dG'*dx)-B*dx*(B*dx)'/(dx'*B*dx);
        
        if norm(points(:,iter+1)-points(:,iter))<eps
            break;
        end
    end
    func(points(1,iter+1),points(2,iter+1))
end
