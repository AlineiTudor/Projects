function [x_est,y_meas,y_estim] = state_estim_nelin(uk,x_ech,x0_real,x0_estim,Ts,Ad,Bd,Cd,Ld)
%x0 must be a column vector
%u must be a row vector
x_real=[];
x_real=[x_real,x0_real];
y_meas=[];
y_meas=Cd*x0_real;

x_est=[];
x_est=[x_est;x0_estim];
y_estim=[];
y_estim=Cd*x0_estim;

y_ech=Cd*x_ech;
for i=1:length(uk)-1
    x_real=[x_real,x_real(:,i)+Ts*cont_pend_nelin(uk(i,:),x_real(:,i))];
    y_meas(:,i+1)=Cd*x_real(:,i);

    x_est(:,i+1)=Ad*x_est(:,i)+Bd*uk(i,:)+Ld*((y_meas(:,i)-y_ech)-y_estim(:,i));
    y_estim(:,i+1)=Cd*x_est(:,i);
end
y_estim(:,i)=Cd*x_est(:,i);
y_estim=y_estim+y_ech;
y_meas(:,i)=Cd*x_real(:,i);
end

