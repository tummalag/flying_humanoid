% Filtered Position 1 data
clc;clear all;close all;
load('filPos3Data.mat')

pos3_x = filPos3Data(:,1);
pos3_y = filPos3Data(:,2);
figure(1);
plot(pos3_x,pos3_y-pos3_y(1,1),'-r')
hold on
eps = 0.0807 -  0.01;
wn = 4.1367 + 0.5 ;
gain = 815;
sys = tf([gain],[1 2*eps*wn wn^2]);
step(sys)
title('System Matching Response for Position 3')
ylabel('theta "\theta"')
legend('System Response','Modeled System Response')
stepinfo(sys)
