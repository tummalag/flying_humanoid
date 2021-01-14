% x = 0:10:100;
% thrust = [0 5.7 87.63 168.39 234.96 283.87 326.11 382.13 422.36  422.36 422.36 ];
% 
% Voltage = [11.99 11.99 11.98 11.97 11.96 11.96 11.96 11.94 11.94 11.94 11.94];
% 
% figure(1)
% p = plot(x,thrust,'-b')
% title(" Duty cycle Vs Thrust ")
% xlabel('% Duty Cycle')
% ylabel('Thrust in gms')
% p.Marker = '*';



figure(2)
sysysys = tf([0.3 10],[1 5 5 10])
step(sysysys)