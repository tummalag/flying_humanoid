
figure(2)
x = impData1(:,1);
y = impData1(:,2);
ss = mean(impData1(end-500:end,2));
plot(impData1(:,1),impData1-(:,2))
hold on;
plot(x,ss*ones(size(x)),'--k')
title('Normal Position Control Implementation')
xlabel('Time in sec')
ylabel('theta "\theta"')
legend('System w Control', 'Steady State Value')

% figure(3)
% plot(impData2(:,1),impData2(:,2))