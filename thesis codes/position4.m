% Filtered Position 1 data
close all;
load('filPos4Data.mat')

pos4_x = filPos4Data(:,1);
pos4_y = filPos4Data(:,2);
figure(1);
plot(pos4_x,pos4_y-pos4_y(1,1),'-r')
hold on
eps = 0.0616 - 0.01 ;
wn = 4.6034 + 0.3 ;
gain = 950;
sys = tf([gain],[1 2*eps*wn wn^2]);
step(sys)
title('System Matching Response for Position 4')
ylabel('theta "\theta"')
legend('System Response','Modeled System Response')
stepinfo(sys)
