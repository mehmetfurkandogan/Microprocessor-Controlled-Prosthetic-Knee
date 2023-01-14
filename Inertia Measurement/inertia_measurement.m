%% Inertia Measurement
% 03.01.2023
clc;clear;close all;
%% IMPORT DATA
data = readtable('log.csv','VariableNamingRule','preserve');
data = table2array(data);
theta = data(:,1); % deg
theta = theta .* pi ./ 180; % rad

time = data(:,2);   % ms
time = time .* 1e-3;    % s
time = time - time(1);  % s
time = time(248:700);   % s

theta = theta(248:700); % rad
time = time - time(1);  % s

fs = 2e3;
theta_f = lowpass(theta,pi/15);
theta_0 = mean(theta(226:361));
theta = theta - theta_0;
theta_f = theta_f - theta_0;

max = islocalmax(theta_f);
min = islocalmin(theta_f);

max_t = theta_f(max);
min_t = theta_f(min);

n = 1;
fprintf('%.3f\n',max_t(2)*180/pi);
fprintf('%.3f\n',max_t(3)*180/pi);

delta = (1/n) * log(max_t(2)/max_t(3));
xi = 1/sqrt(1+(2*pi/delta)^2);

m = 0.580;  % kg
Lcm = 80*1e-3;  % m
T = 0.925;      % s
I = 0.0110947;  % kg*m^2
g = 9.8067;     % m/s^2
c = xi*2*sqrt(m*g*Lcm*I);  % N*s/m
fprintf('delta = %.3f \n',delta);
fprintf('xi = %.3f \n',xi);
fprintf('c = %.3f N*s/m\n',c);

figure();hold on;grid on;
plot(time,theta*180/pi,'k.','linewidth',1);
plot(time,theta_f*180/pi,'k-','linewidth',1);

tspan = [0 4]; % s
y0 = [-theta_0 0]; % rad
[t,y] = ode45(@eom,tspan,y0);
% plot(t,y(:,1)*180/pi,'g-','linewidth',2);

plot(time(max),theta_f(max)*180/pi,'bo','MarkerFaceColor','blue');
plot(time(min),theta_f(min)*180/pi,'ro','MarkerFaceColor','red');
xlim([0 4]);
ylim([-40 40]);
plot(time,exp(-delta*time)*180/pi*3/4,'k--');
plot(time,-exp(-delta*time)*180/pi*3/4,'k--');

legend('Raw Data','Filtered','Maxima','Minima','location','best');
xlabel('Time (s)');ylabel('Angle (\circ)');
