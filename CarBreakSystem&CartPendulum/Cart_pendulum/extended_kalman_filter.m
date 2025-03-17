function [x_real,x_est,y_real,y_est] = extended_kalman_filter(x0,x0_est,nonlin_sist,output_func,state_var,inputs,K,R,Q,P,Ts,kmax)
x_est=[];
y_est=[];
x_est=[x_est,x0_est];

x_real=[];
x_real=[x_real,x0];
y_real=[];

k=1;
u=[];

x_sym=[];
u_sym=[];
ech_point=[0;0;pi;0];
for i=1:length(state_var)
    x_sym=[x_sym,{state_var(i)}];
end
for i=1:length(inputs)
    u_sym=[u_sym,{inputs(i)}];
end
y_real=[y_real,eval(subs(output_func,x_sym',x_real(:,1)))];
n_states=length(state_var);
n_out=length(output_func);
x_pred=[];
I=eye(n_states);
jac=jacobian(nonlin_sist,state_var);
out_jac=jacobian(output_func,state_var);
sqrtR=sqrtm(R);
sqrtQ=sqrtm(Q);
while k<=kmax
    u(:,k)=-K*(x_real(:,k)-ech_point);
    %u(:,k)=0;
    
    %small noise
     x_real=[x_real,x_real(:,k)+Ts*eval(subs(nonlin_sist,[x_sym,u_sym]',[x_real(:,k);u(:,k)]))+sqrtQ*randn(n_states,1)];
     y_real=[y_real,eval(subs(output_func,x_sym',x_real(:,k+1)))+sqrtR*randn(n_out,1)];
    %big noise
    %x_real=[x_real,x_real(:,k)+Ts*eval(subs(nonlin_sist,[x_sym,u_sym]',[x_real(:,k);u(:,k)]))+randn(n_states,1)];
    %y_real=[y_real,eval(subs(output_func,x_sym',x_real(:,k+1)))+randn(n_out,1)];

    %predictie
    x_pred=x_est(:,k)+Ts*eval(subs(nonlin_sist,[x_sym,u_sym]',[x_est(:,k);u(:,k)]));
    A=I+Ts*eval(subs(jac,[x_sym,u_sym]',[x_est(:,k);u(:,k)]));
    P_pred=A*P*A'+Q;
    
    %update
    C=eval(subs(out_jac,x_sym',x_pred));
    K_k=P_pred*C'*inv(C*P_pred*C'+R);
   	x_est(:,k+1)=x_pred+K_k*(y_real(:,k+1)-C*x_pred);
    y_est(:,k+1)=C*x_est(:,k+1);
    P=(I-K_k*C)*P_pred*(I-K_k*C)'+K_k*R*K_k';
    k=k+1;
end
end

