clc;close all; 
load('filPos1Data.mat');
load('filPos2Data.mat');
load('filPos3Data.mat');
load('filPos4Data.mat');

% Filtered Position 1 data
pos1_x = filPos1Data(:,1);
pos1_y = filPos1Data(:,2);
figure(1);
plot(pos1_x,pos1_y-pos1_y(1,1),'-r')
hold on
zeta1 = 0.0673-0.010; wn1 = 5.0066+0.195; gain1 = 1045;
sys1 = tf([gain1],[1 2*zeta1*wn1 wn1^2])
step(sys1)
%stepinfo(sys1)

% Filtered Position 2 data
pos2_x = filPos2Data(:,1);
pos2_y = filPos2Data(:,2);
figure(2);
plot(pos2_x,pos2_y-pos2_y(1,1),'-r')
hold on
zeta2 = 1.504-1.333; wn2 = 2.6424-0.05; gain2 = 223.65 -5;
sys2 = tf([gain2],[1 2*zeta2*wn2 wn2^2]);
step(sys2)
%stepinfo(sys2)

% Filtered Position 3 data
pos3_x = filPos3Data(:,1);
pos3_y = filPos3Data(:,2);
figure(3);
plot(pos3_x,pos3_y-pos3_y(1,1),'-r')
hold on
zeta3 = 0.0807-0.01; wn3 = 4.1367+0.5; gain3 = 815;
sys3 = tf([gain3],[1 2*zeta3*wn3 wn3^2]);
step(sys3)
%stepinfo(sys3)

% Filtered Position 4 data
pos4_x = filPos4Data(:,1);
pos4_y = filPos4Data(:,2);
figure(4);
plot(pos4_x,pos4_y-pos4_y(1,1),'-r')
hold on
zeta4 = 0.0616-0.01; wn4 = 4.6034+0.4; gain4 = 950;
sys4 = tf([gain4],[1 2*zeta4*wn4 wn4^2]);
step(sys4)
%stepinfo(sys4)

