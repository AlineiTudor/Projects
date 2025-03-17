clear all
clc
%params
M=0.5;
m=0.5;
b=0.1;
l=0.3;
I=0.006;
g=9.8;

%Model neliniar
syms x1 x2 x3 x4 u real

c1=M+m-m^2*l^2*cos(x3)^2/(I+m*l^2);
c2=-m*l/(I+m*l^2)*cos(x3)/(m+M-m^2*l^2/(I+m*l^2)*cos(x3)^2);

dx1=x2;
dx2=1/c1*(-b*x2+m^2*l^2*g/(I+m*l^2)*sin(2*x3)/2+m*l*x4^2*sin(x3)+u);
dx3=x4;
dx4=c2*(-b*x2+m^2*l^2*g/2/(I+m*l^2)*sin(2*x3)+m*l*x4^2*sin(x3)+u)-m*g*l/(I+m*l^2)*sin(x3);

x=[x1 x2 x3 x4]';
dx=[dx1 dx2 dx3 dx4]';

%liniarizare
A=jacobian(dx,x);
B=jacobian(dx,u);
x1=0;x2=0;x3=pi;x4=0;u=0;

A=eval(A);
A=vpa(A,2);
B=eval(B);
B=vpa(B,2);
rank(A);

Ar=[0 A(1,2) 0 0;0 A(2,2) A(2,3) 0;0 0 0 A(3,4);0 A(4,2) A(4,3) 0];
Br=[0;B(2);0;B(4)];
A=eval(Ar);
B=eval(Br);
C=[1 0 0 0;0 0 1 0];
Co=[Br Ar*Br Ar^2*Br Ar^3*Br];
rank(Co);

%reactie de la stare
poles=[-1 -2 -50 -60];
K=place(A,B,poles);
%Lundenberg est
Ob=obsv(A,C);
rank(Ob);
L=place(A',C',poles*5);
L=L';


%implementare model discret liniar

%Discretizare
Ts=0.001;
Ad=eye(size(A))+Ts*A;
Bd=Ts*B;
Cd=C;
Dd=0;

%simulare discret liniar
time=0:Ts:5;
uk=zeros(1,length(time));
uk=uk';
x0=[0.1;0;0.1;0];
[xk,yk]=discrete_pend_lin(uk,x0,Ad,Bd,Cd,Dd);
figure
plot(time,yk(2,:)+pi),xlabel('Timp'),ylabel('Unghi pendul'),title('Simulare sistem liniar discret');


%control cu reactie de la stare
Cob_d=ctrb(Ad,Bd);
open_loop_poles=eig(Ad);
rank(Cob_d);
poles_d=exp(poles*Ts);
Kd=place(Ad,Bd,poles_d);

%Reactie de la stare liniar
x0=[0;0;0.1;0];
[xk_feed,yk_feed]=state_feedback_lin(time,x0,Ad,Bd,Cd,Kd);
figure
plot(time,yk_feed(2,:)+pi),xlabel('Timp'),ylabel('Unghi pendul'),title('state feedback liniar');

%Estimator
poles_est=exp(10*poles*Ts);
Ld=place(Ad',Cd',poles_est);
Ld=Ld';
x0_est=[0;0;0.3;0];
[xk_est,yk_est]=state_estim_lin(uk,yk,x0_est,Ad,Bd,Cd,Ld);
figure
plot(time,yk_est(2,:)+pi,time,yk(2,:)+pi),xlabel('Timp'),ylabel('Unghi pendul'),legend('Estimare','poz_reala'),title('estimator-liniar');

%Estimator+state feedback
x0_est=[0;0;1;0];
x0_real=[0;0;0.1;0];
[xk_meas,yk_meas,xk_est,yk_est]=state_estim_feed_lin(time,x0_real,x0_est,Ad,Bd,Cd,Kd,Ld);
figure
plot(time,yk_meas(2,:)+pi,time,yk_est(2,:)+pi),xlabel('Timp'),ylabel('Unghi pendul'),legend('measurement','estimation'),title('Estim+state feed lin');

%discret neliniar
x0_nelin=[0;0;0.001;0];
[x_nel,y_nel]=discrete_pend_nelin(uk,x0_nelin,Ts);
figure
plot(time,y_nel(2,:)),xlabel('Timp'),ylabel('Unghi pendul'),title('Discret nelin');

%reactie de la stare neliniar
%aproapde de pct de ech
x0_nelin=[0;0;pi+0.1;0];
x_ech=[0;0;pi;0];
[x_nelin_feed,y_nel_feed]=state_feedback_nelin(time,x0_nelin,x_ech,Ts,Cd,Kd);
figure
plot(time,y_nel_feed(2,:)),xlabel('Timp'),ylabel('Unghi pendul'),title('reactie de la stare-nelin pi+0.1')
%departe de pct de ech
x0_nelin=[0;0;pi+1.5;0];
x_ech=[0;0;pi;0];
[x_nelin_feed,y_nel_feed]=state_feedback_nelin(time,x0_nelin,x_ech,Ts,Cd,Kd);
figure
plot(time,y_nel_feed(2,:)),xlabel('Timp'),ylabel('Unghi pendul'),title('reactie de la stare-nelin pi+1.5')

%estimator Lundberg pentru sis neliniar discret
x0_lund=[0;0;0.3;0];
x0_real=[0;0;pi+0.1;0];
x_ech=[0;0;pi;0];
time=0:Ts:5;
uk=zeros(1,length(time));uk=uk';
[x_estim_nel,y_meas_nelin,y_est_nelin]=state_estim_nelin(uk,x_ech,x0_real,x0_lund,Ts,Ad,Bd,Cd,Ld);
figure
plot(time,y_meas_nelin(2,:),time,y_est_nelin(2,:)),xlabel('Timp'),ylabel('Unghi pendul'),legend('y measured','y estimated'),title('Esimator sis nelin discret');

%estimator Lundberg+state feed pt sist nelin discret
x0_lund=[0;0;0.3;0];
x0_real=[0;0;pi+0.1;0];
x_ech=[0;0;pi;0];
[x_r_est_feed,y_r_est_feed,x_est_feed_nelin,y_est_feed_nelin] = state_estim_feed_nelin(time,x_ech,x0_lund,x0_real,Ts,Ad,Bd,Cd,Kd,Ld);

figure
plot(time,y_r_est_feed(2,:),time,y_est_feed_nelin(2,:)),xlabel('Timp'),ylabel('Unghi pendul')
legend('y measured-feed','y estimated-feed'),title('State feed+estim pt nelin dis');

%filtrul Kalman
x0_real=[0;0;0.3;0];
x0_est=[0;0;10;0];
a1=0.1;
a2=0.5;
R=a1*eye(2);%output<=>masuratori
Q=a2*eye(4);
high_val=10e4;
P=high_val*eye(4);
kmax=500;
time_sim=0:Ts:kmax*Ts;
[x_est_kalman,x_real_kalman,y_est_kalman,y_real_kalman] = kalman_filter(Ad,Bd,Cd,Kd,x0_real,x0_est,R,Q,P,Ts,kmax);
figure
plot(time_sim,y_real_kalman(2,:)+pi,time_sim,y_est_kalman(2,:)+pi),xlabel('Timp'),ylabel('Unghi pendul')
legend('y measured','y Kalman'),title('Filtrul Kalman')

%EKF
M=0.5;m=0.5;b=0.1;l=0.3;I=0.006;g=9.8;
syms x1 x2 x3 x4 u real

c1=M+m-m^2*l^2*cos(x3)^2/(I+m*l^2);
c2=-m*l/(I+m*l^2)*cos(x3)/(m+M-m^2*l^2/(I+m*l^2)*cos(x3)^2);
dx1=x2;
dx2=1/c1*(-b*x2+m^2*l^2*g/(I+m*l^2)*sin(2*x3)/2+m*l*x4^2*sin(x3)+u);
dx3=x4;
dx4=c2*(-b*x2+m^2*l^2*g/2/(I+m*l^2)*sin(2*x3)+m*l*x4^2*sin(x3)+u)-m*g*l/(I+m*l^2)*sin(x3);

x=[x1 x2 x3 x4]';
dx=[dx1 dx2 dx3 dx4]';
out_func=[x1 x3]';
syms u real;

x0_real=[0;0;pi+0.1;0];
x0_est=[0;0;pi+0.15;0];
a1=0.01;
a2=0.002;
R=a1*eye(2);%output<=>masuratori
Q=a2*eye(4);
high_val=10e4;
P=high_val*eye(4);
kmax=1000;
time_sim=0:Ts:kmax*Ts;
[x_est_ekf,x_real_ekf,y_est_ekf,y_real_ekf] = extended_kalman_filter(x0_real,x0_est,dx,out_func,x,u,Kd,R,Q,P,Ts,kmax);
figure
plot(time_sim,y_real_ekf(2,:),time_sim,y_est_ekf(2,:)),xlabel('Timp'),ylabel('Unghi pendul'),legend('y measured','y EKF'),title('EKF')
%plot(time_sim,y_real_ekf(2,:)),legend('y measured','y EKF')

%%
%estimare perturbatii
%adaugam o perturbatie d(pentru pendul si cart)->[x,d]'
E=[0.5 0 0.1 0]';%conteaza proportia in care infl fiecare componenta a sistemului
nstates=4;
nperturbatii=1;
noutputs=2;
Ae=[Ad E;zeros(1,nstates),ones(1,nperturbatii)];
Be=[Bd;zeros(1,nperturbatii)];
Ce=[Cd,zeros(noutputs,nperturbatii)];
Ob_e=obsv(Ae,Ce);
rank(Ob_e)
poles_e=[poles,-20];
Le=place(Ae',Ce',exp(10*poles_e*Ts));
Le=Le';

%%
%decuplare intrari necunoscute
H=E*pinv(Cd*E);
T=eye(4)-H*Cd;
Ob=obsv(T*Ad,Cd);
rank(Ob);
%mai riguros daca dau polii fata de polii sistemului A-HCA
K1=place((T*Ad)',Cd',exp(10*poles*Ts));
K1=K1';
F=T*Ad-K1*Cd;
K2=F*H;






