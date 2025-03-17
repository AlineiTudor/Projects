
f=@(x1,x2)(81*x1.^2+27*x1.*x2+18*x2.^2+x2.^4-9);
x1=-120:0.8:120;
x2=-120:1:120;
[x1,x2]=meshgrid(x1,x2);
figure
mesh(x1,x2,f(x1,x2));
figure
contour(x1,x2,f(x1,x2)),hold on;

% V1=[-45;37];V2=[43;33];V3=[40;20];
% func=@(x)(81*x(1).^2+27*x(1).*x(2)+18*x(2).^2+x(2).^4-9);
% eps=0.1;
% n_iter_max=10000;
% [point,iter,sequence]=nel_mead(func,V1,V2,V3,eps,n_iter_max);
% func(point)
V1=[1;-1];V2=[2;0];V3=[0;1];
func=@(x)(81*x(1).^2+27*x(1).*x(2)+18*x(2).^2+x(2).^4-9);
eps=0.1;
n_iter_max=3;
[point,iter,sequence]=nel_mead(func,V1,V2,V3,eps,n_iter_max);
func(point)
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