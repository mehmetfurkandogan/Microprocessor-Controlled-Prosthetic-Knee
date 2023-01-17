%% Piston Movement During Walking
% Mehmet Furkan Doğan
% 17.12.2022
clc;clear;close all;
%% IMPORT DATA
load('gait_cycle_data.mat')

% Fourier Series
knee_theta_f = fit_y(knee_theta,t,15,'knee_theta.txt'); % degree
knee_omega_f = fit_y(knee_omega,t,15,'knee_omega.txt'); % degree

% Piston Lenght Calculation
alpha_e = 130;   % degree (full extension)
a = 23.529; % mm (From knee joint to upper piston joint)
b = 180.004; % mm (From knee joint to lower piston joint)
alpha = alpha_e - knee_theta_f;
L_piston = sqrt(a.^2 + b.^2 + 2.*a.*b.*cosd(alpha));    % mm
v_piston = 0.5.*L_piston.^(-1).*(-2).*a.*b.*sind(alpha).*(-knee_omega_f); % mm/s
v_piston = v_piston * 1e-3; % m/s

v_walking = 1.6;    % m/s
cf = v_walking/1.411844;
v_piston = v_piston.*cf;
t = t./cf;

fprintf('For a walking velocity of %.3f m/s : \n',v_walking);
fprintf('Max piston velocity in extension direction: %.3f m/s\n',max(v_piston));
fprintf('Max piston velocity in flexion direction: %.3f m/s\n',(-1)*min(v_piston));

figure('name','Piston Length','numbertitle','off');hold on;grid on;
plot(t,L_piston,'k-','linewidth',1.5);
xlabel('t (s)');ylabel('Piston Lenght (mm)');
xlim([0,t(end)]);xticks(0:0.1:t(end));
yticks(floor(min(L_piston)):2:ceil(max(L_piston)));
title(['Piston length for a walking speed of ',num2str(v_walking),' m/s']);

figure('name','Piston Velocity','numbertitle','off');hold on;grid on;
plot(t,v_piston,'k-','linewidth',1.5);
xlabel('t (s)');ylabel('Piston Velocity (m/s)');
xlim([0,t(end)]);xticks(0:0.1:t(end)/cf);
title(['Piston velocity for a walking speed of ',num2str(v_walking),' m/s']);


% f_knee_theta = figure('name','Knee Angle','numbertitle','off');hold on;grid on;
% plot(t,knee_theta,t,knee_theta_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('Knee angle (degrees)');
% legend('filtered','Fourier series fit','location','best');
% 
% f_knee_omega = figure('name','Knee Angular Velocity','numbertitle','off');hold on;grid on;
% plot(t,knee_omega,t,knee_omega_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('Knee angular velocity (rad/s)');
% legend('filtered','Fourier series fit','location','best');

