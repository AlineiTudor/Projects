function [x_est,x_real,y_est,y_real] = kalman_filter(Ad,Bd,C,K,x0,x0_est,R,Q,P,Ts,kmax)
%u is in line vector with u=[u1 u2 u3...]'
x_est=[];
y_est=[];
x_est=[x_est,x0_est];
y_est=C*x_est;

x_real=[];
x_real=[x_real,x0];
y_real=[];
y_real=C*x_real;

k=1;
u=[];
dim=size(Ad);
n_states=dim(1);
I=eye(n_states);
dim=size(Bd);
n_in=dim(2);
dim=size(C);
n_out=dim(1);
x_pred=zeros(n_states,1);
K_k=[];
proc_add_noise=randn(n_states,kmax);
meas_add_noise=randn(n_out,kmax);
while k<=kmax
    %u(:,k)=-K*x_real(:,k);
    u(:,k)=-K*x_est(:,k);
    
    %measurements from real sistem
    x_real(:,k+1)=Ad*x_real(:,k)+Bd*u(:,k)+randn/50;
    y_real(:,k+1)=C*x_real(:,k+1)+randn/30;
    %x_real(:,k+1)=Ad*x_real(:,k)+Bd*u(:,k)+proc_add_noise(:,k);
    %y_real(:,k+1)=C*x_real(:,k+1)+meas_add_noise(:,k);
    
    %prediction step
    x_pred(:,k+1)=Ad*x_est(:,k)+Bd*u(:,k);
    P_pred=Ad*P*Ad'+Q;
    %Correction step
    K_k=P_pred*C'*inv(C*P_pred*C'+R);
    x_est(:,k+1)=x_pred(:,k+1)+K_k*(y_real(:,k+1)-C*x_pred(:,k+1));
    y_est(:,k+1)=C*x_est(:,k+1);

    P=(I-K_k*C)*P_pred*(I-K_k*C)'+K_k*R*K_k';
    k=k+1;
end

end

