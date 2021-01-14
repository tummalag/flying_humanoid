%sysData = table2array(sysImpData);
figure(1);
plot(sysData(:,1),sysData(:,2),'r-',sysData(:,1),sysData(:,3),'-b')

plot(impData1(:,1),impData1(:,2),'g-',temp2(:,1),temp2(:,2),'-c')
hold on;


plot(temp1(:,1),temp1(:,2),'r-')
hold on;
plot(temp2(:,1),temp2(:,2),'-c')
hold on;
plot(temp3(:,1),temp3(:,2),'-b')
hold on;
plot(temp4(:,1),temp4(:,2),'g-')
hold off;

legend('1','2','3','4')


temp4 = temp1

avg = 0;
block = 15;
for i = 8:1492
    for j=i-7:i+8
       avg = avg + temp4(j,2);
    end
    temp4(i,2) = avg/block;
    avg = 0;
end


