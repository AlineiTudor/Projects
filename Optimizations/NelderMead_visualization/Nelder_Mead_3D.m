% clear 
% clc
% 
% x=-100:1:100;
% y=-100:1:100;
% z=-100:1:100;
% [x,y,z]=meshgrid(x,y,z);
% 
% %contour for a 4d plot->not very useful to visualize it, but it works :)
% func=@(x,y,z)(x.^2+x.*y.*z-z.^2.*y);
% 
% %3d contour
% v=func(x,y,z);
% levellist = linspace(-10,2,7);
% for i = 1:length(levellist)
%     level = levellist(i);
%     p = patch(isosurface(x,y,z,v,level));
%     p.FaceVertexCData = level;
%     p.FaceColor = 'flat';
%     p.EdgeColor = 'none';
%     p.FaceAlpha = 0.3;
% end
% view(3)


func=@(x,y,z)((x+3).^2+(y-2).^2+(z-1).^2+2);
%-------------------
V1=[0,2,3]';
V2=[1,3,8]';
V3=[3,7,5]';
V4=[6,2,10]';
eps=0.001;
n_iter_max=1000;
[min,n_iter]=Neld_Mead_3d(func,V1,V2,V3,V4,eps,n_iter_max);
%---------------------

function [min_point,n_iter]=Neld_Mead_3d(func,V1,V2,V3,V4,eps,n_iter_max)
A=[V1,V2,V3,V1,V4,V2,V3,V4];

figure
plot3(A(1,:),A(2,:),A(3,:)),hold on
grid on

n_iter_max_E=100;
n_iter=0;
while 1
    n_iter=n_iter+1;
    %computing function value for each point
    points=[V1,V2,V3,V4];
    f_val=func(points(1,:),points(2,:),points(3,:));
    
    %getting best to worst points
    [sorted,index]=sort(f_val);
    B=points(:,index(1));
    G1=points(:,index(2));
    G2=points(:,index(3));
    W=points(:,index(4));
    
    %computing M for B---G1
    M=(B+G1)/2;
    %getting reflexion R
    R=2*M-W;
    
    if ( func(R(1),R(2),R(3))<func(W(1),W(2),W(3)) )
        %computing extension if R is better than the worst point W
        E=2*R-M;
        n_iter_E=0;
        %keeping extending while E is better than R or reach max number of
        %iterrations permitted for extensions
        if func(E(1),E(2),E(3))<func(R(1),R(2),R(3))
            E_prev=E;
            %we compute one additional extension to check if we can
            %continue this procedure
            E_c=2*E_prev-R;
            [func(E_c(1),E_c(2),E_c(3));func(E_prev(1),E_prev(2),E_prev(3))]
            while func(E_c(1),E_c(2),E_c(3))<func(E_prev(1),E_prev(2),E_prev(3)) && n_iter_E<n_iter_max_E
                n_iter_E=n_iter_E+1;
                aux=E_c;
                E_c=2*E_c-E_prev;
                E_prev=aux;
            end
            %Extension is better than R
            W=E_prev;
        else
            %Extension is worse than R
            W=R;
        end
    else
        %Reflexion is worse than W
        %Starting computing C1,C2
        C1=(M+W)/2;
        C2=(M+R)/2;
        
        %check to see which one is smaller and better than R
        val_c1=func(C1(1),C1(2),C1(3));
        val_c2=func(C2(1),C2(2),C2(3));
        [val_min,ind_min]=min([val_c1,val_c2]);
        if(ind_min==1)
            C=C1;
        else
            C=C2;
        end
        %chech if C is better than W
        if( val_min<func(W(1),W(2),W(3)) )
            W=C;
        else
            %C is worse than W, computing S
            S=(B+W)/2;
            %Replace G2 with M
            G2=M;
            %Replace W with S
            W=S;
        end
    end
    V1=B;
    V2=G1;
    V3=G2;
    V4=W;
    %plotting points
    A=[V1,V2,V3,V1,V4,V2,V3,V4];
    plot3(A(1,:),A(2,:),A(3,:))
    if( sum([norm(V1-V2),norm(V1-V3),norm(V1-V4),norm(V2-V3),norm(V2-V4),norm(V3-V4)]<eps)==6 || n_iter>n_iter_max)
        %getting best point
        points=[V1,V2,V3,V4];
        f_val=func(points(1,:),points(2,:),points(3,:));
        [sorted,index]=sort(f_val);
        min_point=points(:,index(1));
        break
    end
end
end





