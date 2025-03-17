function [kp,Ti,Td] = FOZN_PID(lambda,r,kc,Tc)

R=r^lambda;
C=cos(lambda*pi/2);
S=sin(lambda*pi/2);
ba_ratio=0.4667;

X=roots([0.467*C-S 0.467*R R*(0.467*C+S)]);
X=X(find(X>0));

alpha=0.6/( 1 + C*(X/R+1/X) );
beta=X/((2*pi)^lambda);
gamma=1/R;

kp=alpha*kc;
Ti=beta*Tc^lambda;
Td=gamma*Ti;
end