function [x,y] = state_feedback_lin(time,x0,Ad,Bd,Cd,Kd)
%x0 must be a column vector
%u must be a row vector
x=[];
x=[x;x0];
y=[];
dim=size(Cd);
y=zeros(dim(1),1);
for i=1:length(time)-1
    x(:,i+1)=(Ad-Bd*Kd)*x(:,i);
    y(:,i+1)=Cd*x(:,i);
end
y(:,i)=Cd*x(:,i);
end

