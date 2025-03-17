clear
clc
% Q=[2 1;1 2];
% c=[-1;-1];
% A=[1 1;-1 1;0 -1];%Matricea ce descrie restrictiile
% b=[2;2;0];%valoarea restrictiilor
% x0=[0;1];

% Q=[4 1;1 6];
% c=[-1;0];
% A=[1 1;1 -1;-1 -1;-1 1];%Matricea ce descrie restrictiile
% b=[1;2;2;1];%valoarea restrictiilor
% x0=[0;1];

%8
% Q=[1 2;2 6];
% c=[-4;-6];
% A=[1 -1;-4 5;1 3;-2 -1];
% b=[2;2;1;-1];
% x0=[1;-1];
% 
% points=duplex_method(Q,c,A,b,x0)

%11
% Q=[1 0;1 4];
% c=[-6;-6];
% A=[1 -5;-2 3;1 3;-2 1];
% b=[2;2;2;1];
% x0=[0;0];
% 
% points=duplex_method(Q,c,A,b,x0)

%ex
Q=[1 2;2 8];
c=[-5;-3];
A=[1 -0.35;1 0.16;-1 0.33;-1 -0.07];
b=[11.64;2.16;1.33;0.92];
x0=[0;0];

points=duplex_method(Q,c,A,b,x0)

function [points]=duplex_method(Q,c,A,b,x0)
n_var=length(x0);
%check if Q is given as a symmetric matrix
if(sum(sum(Q==Q'))~=n_var^2)
    Q=(Q+Q')/2;
end


n_constraints=length(b);
%check to see if x0 fulfills the constraints
if(sum(A*x0<=b)~=n_constraints)
    error('x0 does not fulfill the constraints of A*x0<=b')
    return
end

stop=0;
points=[];
points=[points,x0];
k=1;
s=1;
while ~stop
    %getting all active restrictions: A*x=b
    A*points(:,k);
    w=find(A*points(:,k)==b);
    n_act_rest=length(w);%number of active restrictions
    %computing direction d and aux variables lambda
    d_lambda=[Q A(w,:)';A(w,:) zeros(n_act_rest)]^-1*[-(Q*points(:,k)+c);zeros(n_act_rest,1)];
    d=d_lambda(1:n_var);
    lambda=d_lambda(n_var+1:end);
    %checking direction d
    if(sum(abs(d)<=1e-16)==n_var)
    %if(sum(d==0)==n_var)
        if(sum(lambda>=0)==n_act_rest)
            stop=1;
        else
            %removing the restriction with the smallest negative lambda
            [val_min,index_min]=min(lambda);
            lambda=lambda(lambda~=lambda(index_min))
            %reconstructing Aw for the latest active restrictions
            Aw=A( w(1:n_act_rest~=index_min),: );
            d_lambda=[Q Aw';Aw zeros(n_act_rest-1)]^-1*[-(Q*points(:,k)+c);zeros(n_act_rest-1,1)];
            d=d_lambda(1:n_var);
        end
    end
        %computing step
        aux=A*d;
        steps=[];
        %getting step constraint for Ai*d>0 else the problem constraint is
        %fulfilled
        for i=1:length(aux)
            if((A(i,:)*d>0))
                steps=[steps;( b(i)-A(i,:)*points(:,k) )/(A(i,:)*d)];
            end
        end
        %getting step
        s=min([steps(steps~=0);1]);
    
    points=[points,points(:,k)+s*d];
    k=k+1;
    end
end



