%temp = table2array(temp)

%%
% x = temp(:,1);
% y = temp(:,2);
% 
% first_time = 1.581609358844633e+09;
% last_time =  1.583437030428202e+09;
% 
% for i = 2:length(x)
%     if ((x(i,1) - x(i-1,1)) >1)
%         disp(i);
%     end
% end



for i = 2:length(xw_7)
    xw_7(i,1) = xw_7(i,1) - xw_7(1,1);
end
xw_7(1,1) = 0;


for i = 2:length(x_4)
    x_4(i,1) = x_4(i,1) - x_4(1,1);
end
x_4(1,1) = 0;

%%

figure(1)
% x_1 = temp(1:2444,1);
% y_1 = temp(1:2444,2);
% plot(x_1,y_1)
tempData1 = [x_1,y_1];
%%
figure(2)
% x_2 = temp(2445:2778,1);
% y_2 = temp(2445:2778,2);
%plot(x_2,y_2)
tempData2 = [x_2,y_2];
plot(tempData2)
%%
figure(3)
% x_3 = temp(3504:3855,1);
% y_3 = temp(3504:3855,2);
%plot(x_3,y_3)
tempData3 = [x_3,y_3];

%%
figure(4)
% x_4 = temp(3856:4228,1);
% y_4 = temp(3856:4228,2);
%plot(x_4,y_4)
tempData4 = [x_4,y_4];

%%
for i = 2:length(xw)
    if ((xw(i,1) - xw(i-1,1)) >1)
        disp(i);
    end
end


for i = 2:length(xw_6)
    xw_6(i,1) = xw_6(i,1) - xw_6(1,1);
end
xw_6(1,1) = 0;

%widePos = table2array(widepos);

% xw = widePos(:,1);
% yw = widePos(:,2);
% plot(xw,yw)


figure(2)
% xw_2 = widePos(495:1414,1);
% yw_2 = widePos(495:1414,2);
plot(xw_2,yw_2)
widePosSysRespData1 = [xw_2,yw_2];
plot(widePosSysRespData1)

figure(3)
% xw_3 = widePos(1415:1864,1);
% yw_3 = widePos(1415:1864,2);
plot(xw_3,yw_3)

figure(4)
% xw_4 = widePos(1865:2557,1);
% yw_4 = widePos(1865:2557,2);
plot(xw_4,yw_4)

figure(5)
% xw_5 = widePos(2558:3865,1);
% yw_5 = widePos(2558:3865,2);
plot(xw_5,yw_5)
%widePosSysRespData2 = [xw_5,yw_5];
%plot(widePosSysRespData2)

figure(6)
% xw_6 = widePos(3985:5375,1);
% yw_6 = widePos(3985:5375,2);
plot(xw_6,yw_6)
widePosSysRespNoisyData1 = [xw_6,yw_6];
%%
% Capacito data


for i = 2:length(xw_11)
    xw_11(i,1) = xw_11(i,1) - xw_11(1,1);
end
xw_11(1,1) = 0;


figure(7)
% xw_7 = widePos(6158:8037,1);
% yw_7 = widePos(6158:8037,2);
plot(xw_7,yw_7)
%widePosSysRespCleanData2 = [xw_7,yw_7];

figure(8)
% xw_8 = widePos(8038:9410,1);
% yw_8 = widePos(8038:9410,2);
plot(xw_8,yw_8)

figure(9)
% xw_9 = widePos(9411:10231,1);
% yw_9 = widePos(9411:10231,2);
plot(xw_9,yw_9)

figure(10)
% xw_10 = widePos(10232:10644,1);
% yw_10 = widePos(10232:10644,2);
plot(xw_10,yw_10)


figure(11)
% xw_11 = widePos(10645:11205,1);
% yw_11 = widePos(10645:11205,2);
plot(xw_11,yw_11)


%% Old data

plot(filPos1Data(:,1),filPos1Data(:,2))

figure(21)
plot(widePosData1(:,1),widePosData1(:,2))

figure(22)
plot(widePosData2(:,1),widePosData2(:,2))

figure(23)
plot(normalPosData1(:,1),normalPosData1(:,2))

figure(24)
plot(normalPosData2(:,1),normalPosData2(:,2))

figure(25)
plot(normalPosData3(:,1),normalPosData3(:,2))

figure(26)
plot(impData1(:,1),impData1(:,2))

figure(27)
plot(impData2(:,1),impData2(:,2))

figure(28)
plot(dataNoise1(:,1),dataNoise1(:,2))

figure(29)
plot(dataNoise2(:,1),dataNoise2(:,2))

figure(30)
plot(dataClean1(:,1),dataClean1(:,2))

figure(31)
plot(cleanDataWidePos2(:,1),cleanDataWidePos2(:,2))





