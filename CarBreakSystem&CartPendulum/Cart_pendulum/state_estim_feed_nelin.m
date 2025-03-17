function [x_real,y_meas,x_est,y_estim] = state_estim_feed_nelin(time,x_ech,x0_est,x0_real,Ts,Ad,Bd,Cd,Kd,Ld)
%x0 must be a column vector
%u must be a row vector
x_real=[];
x_real=[x_real,x0_real];
y_meas=[];
y_meas=Cd*x0_real;

x_est=[];
x_est=[x_est;x0_est];
y_estim=[];
y_estim=Cd*x0_est;

y_ech=Cd*x_ech;
for i=1:length(time)-1
    x_real=[x_real,x_real(:,i)+Ts*cont_pend_nelin(-Kd*x_est(:,i),x_real(:,i))];
    y_meas(:,i+1)=Cd*x_real(:,i);

    x_est(:,i+1)=(Ad-Bd*Kd)*x_est(:,i)+Ld*((y_meas(:,i)-y_ech)-y_estim(:,i));
    y_estim(:,i+1)=Cd*x_est(:,i);
end
y_estim(:,i)=Cd*x_est(:,i);
y_estim=y_estim+y_ech;
y_meas(:,i)=Cd*x_real(:,i);

end

