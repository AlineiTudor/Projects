clear
clc

%func=@(x1,x2)(18*x1.^2+20*x2.^4+x1.*x2+x2.^2);
func=@(x1,x2)(81*x1.^2+27*x1.*x2+18*x2.^2+x2.^4-9);
x1=-5:0.1:5;
x2=x1;
[x1,x2]=meshgrid(x1,x2);
z=func(x1,x2);
figure
mesh(x1,x2,z);
figure
contour(x1,x2,z),hold on;

%func=@(x)(18*x(1).^2+20*x(2).^4+x(1).*x(2)+x(2).^2);
func=@(x)(81*x(1).^2+27*x(1).*x(2)+18*x(2).^2+x(2).^4-9);
x0=[-5;-5];
%x0=[-1;1];
%d=[1 0;0 1];
d=[sqrt(2)/2 sqrt(2)/2;sqrt(2)/2 -sqrt(2)/2];
s=[0.3,0.6];
%s=[0.1,0.2]
alpha=3;
beta=-1/5;
%alpha=2;
%beta=-0.2;
eps=0.001;
n_iter_max=10000;
[points,n_iter]=rosenbrock(func,x0,d,s,alpha,beta,eps,n_iter_max);
plot(points(1,:),points(2,:));

V1=[1;-1];V2=[2;0];V3=[0;1];
%func=@(x)(81*x(1).^2+27*x(1).*x(2)+18*x(2).^2+x(2).^4-9);
eps=0.1;
n_iter_max=100;
[point,iter,sequence]=nel_mead(func,V1,V2,V3,eps,n_iter_max);

function [points,n_iter]=rosenbrock(func,x0,d,s,alpha,beta,eps,n_iter_max)
%-1<beta<0
%alpha>1
%make sure alpha*beta!=1
    k=1;
    stop=0;
    n_var=length(x0);
    n_iter=0;
    points=x0;
    while ~stop && k<=n_iter_max
        success=zeros(1,n_var);
        fail=success;
        dist=success;
        oscil=0;
        while ~oscil && n_iter<=n_iter_max
            n_iter=n_iter+1;
            for i=1:n_var%for all directions
                x_try=points(:,k)+s(i)*d(:,i);
                if func(x_try)<func(points(:,k))
                    success(i)=1;%success for d(i) direction
                    k=k+1;
                    points=[points,x_try];%adding new point that gives a smaller function value
                    dist(i)=dist(i)+s(i);%counting the distance travelled in that direction
                    s(i)=s(i)*alpha;%increasing step in that direction
                    
                    %checking if we reached the maximum tolerance admitted
                    %to stop the whole algorithm
                    if norm( points(:,k-1)-x_try)<eps
                        stop=1
                        break
                    end                   
                else %the computed point in that direction was worse
                    fail(i)=1;%marked direction d(i) as a fail
                    s(i)=beta*s(i);%we decrease the step length for the d(i) direction
                end
            end
            %check to see if we obtained at least one success in a
            %direction and a fail=>we got oscillation
            if sum(success)+sum(fail)==2*n_var
                oscil=1;
            end
        end
        if ~stop
            d=Gramm_Schmidt_ortogonalization(d,dist);
        end
    end
    n_iter=k;
end


function [point,iter,sequence]=nel_mead(func,V1,V2,V3,eps,n_iter_max)
    iter=1;
    points_plot=[V1,V2,V3,V1];
    %plotig points
    plot(points_plot(1,:),points_plot(2,:)), hold on;
    
    %sequence stores the type of points computed and used 
    sequence=[];
    while 1 && iter<=n_iter_max
        points=[V1,V2,V3];
        [val,index]=sort([func(V1),func(V2),func(V3)]);
        B=points(:,index(1));
        G=points(:,index(2));
        W=points(:,index(3));
        %middle
        M=(B+G)/2;
        %reflection
        R=2*M-W;
  
        if func(R)<func(W)
            %try extension
            E_c=2*R-M;
            %try multiple extensions
            E_p=R;
            if func(E_c)<func(R)
                while func(E_c)<func(E_p)
                    aux=E_c;
                    E_c=2*E_c-E_p;
                    E_p=aux;
                end
                sequence=[sequence;{'extension'}];
                W=E_p;
            else
                sequence=[sequence;{'reflection'}];
                W=R;
            end
        else
            C=[(M+W)/2,(M+R)/2];
            [val,index]=sort( [func( C(:,1) ),func( C(:,1) )] );
            C=C(:,index(1));
            if func(C)<func(W)
                W=C;
                sequence=[sequence;{strcat('contract C',num2str( index(1) ))}];
            else
                sequence=[sequence;{'compute S'}];
                S=(B+W)/2;
                W=S;
                G=M;
            end   
        end
        V1=B;
        V2=G;
        V3=W;
        
        %plotig points
        points_plot=[V1,V2,V3,V1];
        plot(points_plot(1,:),points_plot(2,:));
        
        if( norm(V1-V2)<eps && norm(V2-V3)<eps && norm(V1-V3)<eps)
            %getting best point
            points=[V1,V2,V3];
            [val,index]=sort([func(V1),func(V2),func(V3)]);
            B=points(:,index(1));
            break;
        end
        iter=iter+1;
    end
    point=B;
end