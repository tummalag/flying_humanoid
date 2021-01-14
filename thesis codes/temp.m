%[mvngAvg,b] = smoothdata(impData1(:,2),'movmedian');
[gauAvg,a] = smoothdata(impData1(:,2),'gaussian');
% linregAvg = smoothdata(impData1(:,2),'lowess');
% quadregAvg = smoothdata(impData1(:,2),'loess');
% sgolayAvg = smoothdata(impData1(:,2),'sgolay');


figure(1)
%plot(mvngAvg)
% figure(2)
plot(gauAvg)
% figure(3)
% plot(gauAvg)
% figure(4)
% plot(gauAvg)
% figure(5)
% plot(gauAvg)
% 
