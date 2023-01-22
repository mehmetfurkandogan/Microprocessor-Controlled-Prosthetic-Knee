%% Inertia Measurement
% 03.01.2023
clc;clear;close all;
%% IMPORT DATA
data = readtable('log.csv','VariableNamingRule','preserve');
data = table2array(data);
theta = data(:,1); % deg
theta = theta .* pi ./ 180; % rad (deg to rad conversion)

time = data(:,2);   % ms
time = time .* 1e-3;    % s (ms to s conversion)
%time = time - time(1);  % s (set initial time to 0)
time = time(250:700);   % s  (clip a section from data)
theta = theta(250:700); % rad (clip a section from data)
time = time - time(1);  % s (set initial time to 0)

% Lowpass Filter
fs = 2e3;
theta_f = lowpass(theta,pi/15);
theta_0 = mean(theta(226:361)); % (set 0 value of the angle)
theta = theta - theta_0;        % (set 0 value of the angle)
theta_f = theta_f - theta_0;    % (set 0 value of the angle)

% Finding local extrema for logarithmic decrement
max = islocalmax(theta_f);
min = islocalmin(theta_f);

max_t = theta_f(max);
min_t = theta_f(min);

% Logarithmic decrement
n = 1;
delta = (1/n) * log(max_t(2)/max_t(3)); % Logarithmic decrement
xi = 1/sqrt(1+(2*pi/delta)^2);  % damping ratio


f1=figure('name','Inertia Measurement','numberTitle','off');hold on;grid on;
f1.Position = [144   247   560   420];
plot(time,theta*180/pi,'k.','linewidth',1,'DisplayName','Raw Data');
plot(time,theta_f*180/pi,'k-','linewidth',1,'DisplayName','Filtered Data');

% Solving the Equation of Motion
tspan = [0 6]; % s
y0 = [-theta_0 0]; % rad
sol = ode45(@eom,tspan,y0);

theta_s = deval(sol,time);
theta_s = theta_s(1,:).';

plot(time,theta_s*180/pi,'g-','linewidth',2,'DisplayName','ODE Solution');



% plot(time(max),theta_f(max)*180/pi,'bo','MarkerFaceColor','blue');
% plot(time(min),theta_f(min)*180/pi,'ro','MarkerFaceColor','red');
xlim([0 4]);
ylim([-40 40]);
% plot(time,exp(-delta*time)*180/pi*3/4,'k--');
% plot(time,-exp(-delta*time)*180/pi*3/4,'k--');

legend

xlabel('Time (s)');ylabel('Angle (\circ)');

%% Animation
% Knee to Ankle lenght is 42.5 cm
L = 425;    % m
knee = [0,0];
ankle_f = L * exp(1i*theta_f);
ankle_x = real(ankle_f);
ankle_y = imag(ankle_f);
ankle_f = knee - [ankle_x ankle_y];
clear ankle_x;clear ankle_y;

ankle_s = L * exp(1i*theta_s);
ankle_x = real(ankle_s);
ankle_y = imag(ankle_s);
ankle_s = knee - [ankle_x ankle_y];
clear ankle_x;clear ankle_y;


%% Plotting
f2 = figure('name','Inertia Measurement','numberTitle','off');
f2.Position = [706   246   560   420];
hold on;
set(gca,'NextPlot','replacechildren','DataAspectRatio',[1 1 1]);
xlim([0 10000]);ylim([0 1200]);

xmin=-300;xmax = 300;
ymin=-500;ymax = 100;
xlim([xmin xmax]);ylim([ymin ymax]);

for i = 1:361
    figure(f2);
    clf
    set(gca,'NextPlot','replacechildren','DataAspectRatio',[1 1 1]);
    xlim([xmin xmax]);ylim([ymin ymax]);
    grid on;
    hold on;
    plot([knee(1) ankle_f(i,2)],[knee(2) ankle_f(i,1)],'k-o','linewidth',1.5);

    plot([knee(1) ankle_s(i,2)],[knee(2) ankle_s(i,1)],'g-o','LineWidth',1.5);

    title(strcat('t = ',num2str(time(i)),' s'));
    F(i) = getframe;
    clc;fprintf('t = %.3f s\n',time(i));
end
fps = size(time,1)/4;
movie(F,1,fps);