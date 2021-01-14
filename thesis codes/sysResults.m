close all;
%sys = tf([1 -43],[1 0.5 1]);

% Filtered Position 1 data
pos1_x = filPos1Data(:,1);
pos1_y = filPos1Data(:,2);
ss1 = mean(filPos1Data(end-1000:end,2));
ss1_2P = (max(pos1_y)-min(pos1_y))*2/100;
ss1_5P = (max(pos1_y)-min(pos1_y))*5/100;
figure(1);
plot(pos1_x,pos1_y,'-r')
title('System Response for Position 1')
xlabel('Time (seconds)')
ylabel('theta "\theta"')
legend('System Response')
% hold on
% %step(sys)
% 
% plot(pos1_x,ss1*ones(size(pos1_x)),'-k')
% plot(pos1_x,[(ss1-ss1_2P)*ones(size(pos1_x)),(ss1+ss1_2P)*ones(size(pos1_x))], '-g')
% plot(pos1_x,[(ss1-ss1_5P)*ones(size(pos1_x)),(ss1+ss1_5P)*ones(size(pos1_x))], '-r')

% Filtered Position 2 Data
pos2_x = filPos2Data(:,1);
pos2_y = filPos2Data(:,2);
ss2 = mean(filPos2Data(end-1000:end,2));
ss2_2P = (max(pos2_y)-min(pos2_y))*2/100;
ss2_5P = (max(pos2_y)-min(pos2_y))*5/100;
figure(2);
plot(pos2_x,pos2_y,'-r')
title('System Response for Position 2')
xlabel('Time (seconds)')
ylabel('theta "\theta"')
legend('System Response')
% hold on
% plot(pos2_x,ss2*ones(size(pos2_x)),'-k')
% plot(pos2_x,[(ss2-ss2_2P)*ones(size(pos2_x)),(ss2+ss2_2P)*ones(size(pos2_x))], '-g')
% plot(pos2_x,[(ss2-ss2_5P)*ones(size(pos2_x)),(ss2+ss2_5P)*ones(size(pos2_x))], '-r')

% Filtered Position 3 Data
pos3_x = filPos3Data(:,1);
pos3_y = filPos3Data(:,2);
ss3 = mean(filPos3Data(end-1000:end,2));
ss3_2P = (max(pos3_y)-min(pos3_y))*2/100;
ss3_5P = (max(pos3_y)-min(pos3_y))*5/100;
figure(3);
plot(pos3_x,pos3_y,'-b')
hold on
plot(pos3_x,ss3*ones(size(pos3_x)),'-k')
plot(pos3_x,[(ss3-ss3_2P)*ones(size(pos3_x)),(ss3+ss3_2P)*ones(size(pos3_x))], '-g')
plot(pos3_x,[(ss3-ss3_5P)*ones(size(pos3_x)),(ss3+ss3_5P)*ones(size(pos3_x))], '-r')

% Filtered Position 4 Data
pos4_x = filPos4Data(:,1);
pos4_y = filPos4Data(:,2);
ss4 = mean(filPos4Data(end-1000:end,2));
ss4_2P = (max(pos4_y)-min(pos4_y))*2/100;
ss4_5P = (max(pos4_y)-min(pos4_y))*5/100;
figure(4);
plot(pos4_x,pos4_y,'-b')
hold on
plot(pos4_x,ss4*ones(size(pos4_x)),'-k')
plot(pos4_x,[(ss4-ss4_2P)*ones(size(pos4_x)),(ss4+ss4_2P)*ones(size(pos4_x))], '-g')
plot(pos4_x,[(ss4-ss4_5P)*ones(size(pos4_x)),(ss4+ss4_5P)*ones(size(pos4_x))], '-r')

