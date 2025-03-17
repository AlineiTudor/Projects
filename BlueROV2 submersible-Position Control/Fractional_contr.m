clc, clear, close all
freq=0.18;
Omega=2*pi*freq;

SimTime=300;
samplingTime=0.01;
sim_data=sim('iden_sin_real');

y_mean=mean(sim_data.Y)
y=sim_data.Y;
u=sim_data.U;

figure
plot(sim_data.U), hold on
plot(sim_data.Y)
title('Original simulation input-output')
legend('U','Y');

%%
phm=80/180*pi;
omg_cut=Omega;
y_norm=y-y_mean;

figure
plot(u), hold on
plot(y_norm)
title('Original simulation input-output')
legend('U','Y');

%for X
M=-max(y_norm);
%here it T_i-T_o
Phi=freq*2*pi*( (27918-28129)*samplingTime );

%%
%sine test

out=sim("sine_test_sin_ideal");
yb=out.Ybar;
figure
plot(u), hold on
plot(y_norm),hold on
plot(yb)
title('Original simulation input-output')
legend('U','Y','YB');

%%
%X
MB=0.045;
PhiB=2*pi*freq*(0);

wt = omg_cut;
phase_deriv = MB/M*cos(PhiB-Phi);
%phase_deriv =  -0.933888437118822;
process_phase = Phi;

data1=[];data2=[];data3=[];
for miu=0.2:0.001:2
    % calcul (L'*K-L*K')/(L^2+K^2)
    z1=miu*wt^(-miu-1)*sin(pi*miu/2);
    z2=2*wt^(-miu)*cos(pi*miu/2);
    z3=wt^(-2*miu);

    % se calculeaza ki

    ki1= -((z1+z2*phase_deriv)+sqrt((z1+z2*phase_deriv)^2-4*z3*phase_deriv^2))/(2*z3*phase_deriv);
    ki2= -((z1+z2*phase_deriv)-sqrt((z1+z2*phase_deriv)^2-4*z3*phase_deriv^2))/(2*z3*phase_deriv);
    
    ki3= (tan(pi-phm+process_phase)*(wt^miu))/(sin(pi*miu/2)-(tan(pi-phm+process_phase)*cos(pi*miu/2)));
    data1 = [data1; [ki1]];
    data2 = [data2; [ki2]];
    data3 = [data3; [ki3]];

end

miu=0.2:0.001:2;
figure; plot(miu,data1,'r')
hold on,plot(miu,data3,'b'),title('ki1 vs ki3'),grid

figure; plot(miu,data2,'r')
hold on, plot(miu,data3,'b'),title('ki2 vs ki3'),grid

