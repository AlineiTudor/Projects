function [x,y] = state_estim_lin(uk,y_meas,x0,Ad,Bd,Cd,Ld)
%x0 must be a column vector
%u must be a row vector
x=[];
x=[x;x0];
y=[];
y=Cd*x0;
for i=1:length(uk)-1
    x(:,i+1)=Ad*x(:,i)+Bd*uk(i,:)+Ld*(y_meas(:,i)-y(:,i));
    y(:,i+1)=Cd*x(:,i);
end
y(:,i)=Cd*x(:,i);

end

