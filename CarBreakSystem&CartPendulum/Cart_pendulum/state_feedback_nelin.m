function [x,y] = state_feedback_nelin(time,x0,x0_ech,Ts,Cd,Kd)
%x0 must be a column vector
%u must be a row vector
x=[];
x=[x;x0];
y=[];
dim=size(Cd);
y=zeros(dim(1),1);
for i=1:length(time)-1
    x=[x,x(:,i)+Ts*cont_pend_nelin(-Kd*(x(:,i)-x0_ech),x(:,i))];
    y(:,i+1)=Cd*x(:,i);
end
y(:,i)=Cd*x(:,i);
end

