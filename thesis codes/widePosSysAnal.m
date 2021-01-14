%clc;%clear all;
load('cleanDataWidePos2.mat');
pos1_x = cleanDataWidePos2(:,1);
pos1_y = cleanDataWidePos2(:,2);
figure(1);

plot(pos1_x,pos1_y-pos1_y(1,1),'-r')
hold on;
% Initialization
iniForce = 0.0901;
gain = 130;
zeta =  0.4037;
wn =  2.5193;
Gp = tf(gain,[1 2*zeta*wn wn^2])
[gpnum,gpden] = tfdata(Gp)
step(Gp)
title('Model Matching')
xlabel('Time')
ylabel('theta (\theta) in degree(\circ)','FontSize',10,'FontWeight','bold')
legend('Real System','Model System')

%% Designing a compensator 1
% Poles of the desired systems
syms a b;
rt = 3;
po = 5;
[a,b]= solve(pi-atan(sqrt(1 - a^2)/a)/(b*sqrt(1-a^2))-rt , 100*exp((-a*pi)/sqrt(1-a^2))-po);

zetaDes = double(a);
wnDes = double(b);

Sd1 = (-zetaDes*wnDes + 1i*wnDes*sqrt(1-zetaDes^2));
Sd2 = (-zetaDes*wnDes - 1i*wnDes*sqrt(1-zetaDes^2));
%Sd1=Sd2;
phi = phase(freqresp(Gp,Sd1))*180/pi-360;
phiC = -180 - phi;
zc = real(Sd1);
phiZc = phase(Sd1-zc)*180/pi;
phiPc = phiZc - phiC;
pc =    real(Sd1) - imag(Sd1)/tand(phiPc);
% Gain
K = abs(Sd1-pc)/(abs(Sd1-zc)*abs(freqresp(Gp,Sd1)));
% Lead compensator
Gct = K*tf([1 -zc],[1 -pc]);
essDes = 1;
KvDes = 1/essDes;
KvCurr =  abs(freqresp(Gp*Gct,essDes));
alphaLag = KvDes/KvCurr;
Zc = real(Sd1);
Pc = Zc/alphaLag;
%% PD Controller system
T = -1/Pc;
Kp = K*Zc/Pc;
Kd = K*T;
Ki = 10;
C = tf([Kd Kp],[T 1]);
%% Plotting
%C1 = pid(0.01,0,0.005);
C1 = pid(Kp,Ki,Kd);
figure(2)
TT = feedback(C*Gp,1);
CF = feedback(C,Gp);
opt = stepDataOptions('StepAmplitude',1);
step(TT,opt)
title({'PD Controller Implementation', '(Step Response)'})
xlabel('Time')
ylabel('\theta','FontSize',12,'FontWeight','bold')
%stepinfo(CF)
