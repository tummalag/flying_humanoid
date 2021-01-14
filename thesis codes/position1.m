% Filtered Position 1 data
close all;
load('filPos1Data.mat')
pos1_x = filPos1Data(:,1);
pos1_y = filPos1Data(:,2);
figure(1);
plot(pos1_x,pos1_y-pos1_y(1,1),'-r')
hold on
eps = 0.0673-0.018; wn = 5.0066+0.195;
sys = tf([1045],[1 2*eps*wn wn^2]);
step(sys)
title('System Matching Response for Position 1')
ylabel('theta "\theta"')
legend('System Response','Modeled System Response')
stepinfo(sys)
