%close all;
sys = tf([1 -43],[1 0.5 1]);

% Wide Position data 1
pos1_x = dataClean1(:,1);
pos1_y = dataClean1(:,2);
ss1 = mean(dataClean1(end-100:end,2));
ss1_2P = (max(pos1_y)-min(pos1_y))*2/100;
ss1_5P = (max(pos1_y)-min(pos1_y))*5/100;
figure(1);
plot(pos1_x,pos1_y,'-b')
hold on
%step(sys)
plot(pos1_x,ss1*ones(size(pos1_x)),'-k')
plot(pos1_x,[(ss1-ss1_2P)*ones(size(pos1_x)),(ss1+ss1_2P)*ones(size(pos1_x))], '-g')
plot(pos1_x,[(ss1-ss1_5P)*ones(size(pos1_x)),(ss1+ss1_5P)*ones(size(pos1_x))], '-r')

% Wide Position Data 2
pos2_x = widePosData2(:,1);
pos2_y = widePosData2(:,2);
ss2 = mean(widePosData2(end-100:end,2));
ss2_2P = (max(pos2_y)-min(pos2_y))*2/100;
ss2_5P = (max(pos2_y)-min(pos2_y))*5/100;
figure(2);
plot(pos2_x,pos2_y,'-b')
hold on
plot(pos2_x,ss2*ones(size(pos2_x)),'-k')
plot(pos2_x,[(ss2-ss2_2P)*ones(size(pos2_x)),(ss2+ss2_2P)*ones(size(pos2_x))], '-g')
plot(pos2_x,[(ss2-ss2_5P)*ones(size(pos2_x)),(ss2+ss2_5P)*ones(size(pos2_x))], '-r')

% Normal Position Data 1
pos3_x = normalPosData1(:,1);
pos3_y = normalPosData1(:,2);
ss3 = mean(normalPosData1(end-100:end,2));
ss3_2P = (max(pos3_y)-min(pos3_y))*2/100;
ss3_5P = (max(pos3_y)-min(pos3_y))*5/100;
figure(3);
plot(pos3_x,pos3_y,'-b')
hold on
%step(tf5*210)
plot(pos3_x,ss3*ones(size(pos3_x)),'-k')
plot(pos3_x,[(ss3-ss3_2P)*ones(size(pos3_x)),(ss3+ss3_2P)*ones(size(pos3_x))], '-g')
plot(pos3_x,[(ss3-ss3_5P)*ones(size(pos3_x)),(ss3+ss3_5P)*ones(size(pos3_x))], '-r')

% Normal Position Data 2
pos4_x = normalPosData2(:,1);
pos4_y = normalPosData2(:,2);
ss4 = mean(normalPosData2(end-100:end,2));
ss4_2P = (max(pos4_y)-min(pos4_y))*2/100;
ss4_5P = (max(pos4_y)-min(pos4_y))*5/100;
figure(4);
plot(pos4_x,pos4_y,'-b')
hold on
plot(pos4_x,ss4*ones(size(pos4_x)),'-k')
plot(pos4_x,[(ss4-ss4_2P)*ones(size(pos4_x)),(ss4+ss4_2P)*ones(size(pos4_x))], '-g')
plot(pos4_x,[(ss4-ss4_5P)*ones(size(pos4_x)),(ss4+ss4_5P)*ones(size(pos4_x))], '-r')


% Normal Position Data 3
pos5_x = normalPosData3(:,1);
pos5_y = normalPosData3(:,2);
ss5 = mean(normalPosData3(end-100:end,2));
ss5_2P = (max(pos5_y)-min(pos5_y))*2/100;
ss5_5P = (max(pos5_y)-min(pos5_y))*5/100;
figure(5);
plot(pos5_x,pos5_y,'-b')
hold on
plot(pos5_x,ss5*ones(size(pos5_x)),'-k')
plot(pos5_x,[(ss5-ss5_2P)*ones(size(pos5_x)),(ss5+ss5_2P)*ones(size(pos5_x))], '-g')
plot(pos5_x,[(ss5-ss5_5P)*ones(size(pos5_x)),(ss5+ss5_5P)*ones(size(pos5_x))], '-r')

