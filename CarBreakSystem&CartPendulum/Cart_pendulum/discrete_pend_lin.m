function [x,y] = discrete_pend_lin(u,x0,Ad,Bd,Cd,Dd)
%x0 must be a column vector
%u must be a row vector
x=[];
x=[x;x0];
y=[];
dim=size(Cd);
y=zeros(dim(1),1);
for i=1:length(u)-1
    x(:,i+1)=Ad*x(:,i)+Bd*u(i,:);
    y(:,i+1)=Cd*x(:,i)+Dd*u(i,:);
end
y(:,i)=Cd*x(:,i)+Dd*u(i,:);
end

