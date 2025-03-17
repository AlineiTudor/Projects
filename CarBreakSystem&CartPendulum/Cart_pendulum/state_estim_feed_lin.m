function [x_meas,y_meas,x_est,y_est] = state_estim_feed_lin(time,x0_real,x0_est,Ad,Bd,Cd,Kd,Ld)
x_meas=[];
x_meas=[x_meas,x0_real];
x_est=[];
x_est=[x_est,x0_est];

y_meas=Cd*x0_real;
y_est=Cd*x0_est;
%aici controlul e cu starile estimate pe sistemul real-de modificat
for i=1:length(time)-1
    x_est(:,i+1)=(Ad-Bd*Kd)*x_est(:,i)+Ld*(y_meas(:,i)-y_est(:,i));
    x_meas(:,i+1)=Ad*x_meas(:,i)-Bd*Kd*x_est(:,i);
    y_est(:,i+1)=Cd*x_est(:,i);
    y_meas(:,i+1)=Cd*x_meas(:,i);
end

end

