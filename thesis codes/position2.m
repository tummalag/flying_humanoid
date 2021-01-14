% Filtered Position 2 data
close all;
load('filPos2Data.mat')

pos2_x = filPos2Data(:,1);
pos2_y = filPos2Data(:,2);
figure(1);
plot(pos2_x,pos2_y-pos2_y(1,1),'-r')
hold on
eps = 1.504-1.333;
wn = 2.6424-0.05 ;
gain = 223.65 -5;
sys = tf([gain],[1 2*eps*wn wn^2]);
step(sys)
title('System Matching Response for Position 2')
ylabel('theta "\theta"')
legend('System Response','Modeled System Response')
stepinfo(sys)
