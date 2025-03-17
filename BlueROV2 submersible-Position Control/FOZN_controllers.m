close all
dimensions=size(out.ROV_pose2);
t=out.tout;

x=reshape(out.ROV_pose1(1,:,:),[1,dimensions(3)]);
y=reshape(out.ROV_pose1(2,:,:),[1,dimensions(3)]);
z=reshape(out.ROV_pose1(3,:,:),[1,dimensions(3)]);
x_ref=out.Ref_pose1(:,1);
y_ref=out.Ref_pose1(:,2);
z_ref=out.Ref_pose1(:,3);
figure
plot3(x,y,z), hold on, plot3(x_ref,y_ref,z_ref)
xlabel('X'),ylabel('Y'),zlabel('Z')

x=reshape(out.ROV_pose2(1,:,:),[1,dimensions(3)]);
y=reshape(out.ROV_pose2(2,:,:),[1,dimensions(3)]);
z=reshape(out.ROV_pose2(3,:,:),[1,dimensions(3)]);
x_ref=[0;out.Ref_pose2(:,1)];
y_ref=[0;out.Ref_pose2(:,2)];
z_ref=[10;out.Ref_pose2(:,3)];
figure
plot3(x,y,z), hold on, plot3(x_ref,y_ref,z_ref)
xlabel('X'),ylabel('Y'),zlabel('Z')



% figure
% subplot(2,1,1)
% plot(t,u), title('Input')
% subplot(2,1,2)
% plot(t,y), title('Output')

%%
r=5;
app_order=5;
freq_range=[0.01 10];

%surge controller
d=3;%command value with switch on/off at 0.5
a=(0.4179+0.4277)/2;%amplitude of oscillations
Tc=415.2-395.86;
Kc=4*d/(pi*a);

lambda_surge=0.4;
[Kp_surge,Ti_surge,Td_surge]=FOZN_PID(lambda_surge,r,Kc,Tc);

%-----------------------
%Heave controller
d=2;%command value with switch on/off at 0.5
a=(0.5567+0.5679)/2;%amplitude of oscillations
Tc=317.94-303.23;
Kc=4*d/(pi*a);

lambda_heave=0.4;
[Kp_heave,Ti_heave,Td_heave]=FOZN_PID(lambda_heave,r,Kc,Tc);

%-----------------------
%sway controller
d=15;%command value with switch on/off at 4
a=(14.03+5.9)/2;%amplitude of oscillations
Tc=441.99-411.88;
Kc=4*d/(pi*a);

lambda_sway=0.95;
[Kp_sway,Ti_sway,Td_sway]=FOZN_PID(lambda_sway,r,Kc,Tc);

%-----------------------
%roll controller
d=4;%command value with switch on/off at 10
a=(10.04+9.782)/2;%amplitude of oscillations
Tc=452.66-427.02;
Kc=4*d/(pi*a);

lambda_roll=0.4;
[Kp_roll,Ti_roll,Td_roll]=FOZN_PID(lambda_roll,r,Kc,Tc);

%-----------------------
%pitch controller
d=5;%command value with switch on/off at 10
a=(-7.87+10.09)/2;%amplitude of oscillations
Tc=465.06-462.41;
Kc=4*d/(pi*a);

lambda_pitch=0.4;
[Kp_pitch,Ti_pitch,Td_pitch]=FOZN_PID(lambda_pitch,r,Kc,Tc);

%-----------------------
%yaw controller
d=5;%command value with switch on/off at 10
a=(9.994+9.995)/2;%amplitude of oscillations
Tc=476.14-453.13;
Kc=4*d/(pi*a);

lambda_yaw=0.4;
[Kp_yaw,Ti_yaw,Td_yaw]=FOZN_PID(lambda_yaw,r,Kc,Tc);