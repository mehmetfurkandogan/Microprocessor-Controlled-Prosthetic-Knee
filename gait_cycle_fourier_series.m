%% Gait Cycle Analysis using Fourier Series
% Mehmet Furkan Doğan
% 12 November 2022
clc;clear;close all;
%% IMPORT DATA
load('gait_cycle_data.mat');

%% CALCULATIONS
%%  POSITIONS
rib_x_f = fit_x(rib_x,t,8,'rib_x');
rib_y_f = fit_y(rib_y,t,8,'rib_y');

hip_x_f = fit_x(hip_x,t,8,'hip_x');
hip_y_f = fit_y(hip_y,t,8,'hip_y');

knee_x_f = fit_x(knee_x,t,8,'knee_x');
knee_y_f = fit_y(knee_y,t,15,'knee_y');

knee_ax_f = fit_y(knee_ax,t,15,'knee_ax');
knee_ay_f = fit_y(knee_ay,t,15,'knee_ay');

fibula_x_f = fit_x(fibula_x,t,8,'fibula_x');
fibula_y_f = fit_y(fibula_y,t,15,'fibula_y');

ankle_x_f = fit_x(ankle_x,t,15,'ankle_x');
ankle_y_f = fit_y(ankle_y,t,15,'ankle_y');

heel_x_f = fit_x(heel_x,t,15,'heel_x');
heel_y_f = fit_y(heel_y,t,15,'heel_y');

metat_x_f = fit_x(metat_x,t,15,'metat_x');
metat_y_f = fit_y(metat_y,t,15,'metat_y');

toe_x_f = fit_x(toe_x,t,15,'toe_x');
toe_y_f = fit_y(toe_y,t,15,'toe_y');

%%  ANGLES
foot_theta_f = fit_y(foot_theta,t,15,'foot_theta');     % degree
leg_theta_f = fit_y(leg_theta,t,15,'leg_theta');     % degree
thigh_theta_f = fit_y(thigh_theta,t,15,'thigh_theta');   % degree
HAT_theta_f = fit_y(HAT_theta,t,15,'HAT_theta');     % degree
% A4
hip_theta_f = fit_y(hip_theta,t,15,'hip_theta');    % degree
knee_theta_f = fit_y(knee_theta,t,15,'knee_theta'); % degree
ankle_theta_f = fit_y(ankle_theta,t,15,'ankle_theta'); % degree
%% FORCES AND MOMENTS
F_foot_ground_x_f = fit_y(F_foot_ground_x,t,17,'F_foot_ground_x');  % N
F_foot_ground_y_f = fit_y(F_foot_ground_y,t,17,'F_foot_ground_y');  % N

%% Angular Velocities
leg_omega_f = fit_y(leg_omega,t,10,'leg_omega');     % N

%% PLOT
% %% RIB X
% figure('name','Rib x coordinate','numbertitle','off');hold on;grid on;
% plot(t,rib_x,t,rib_x_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('rib x (mm)');
% legend('filtered','Fourier series fit','location','best');
% %% RIB Y
% figure('name','Rib y coordinate','numbertitle','off');hold on;grid on;
% plot(t,rib_y,t,rib_y_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('rib y (mm)');
% legend('filtered','Fourier series fit','location','best');
% 
% %% HIP X
% figure('name','Hip x coordinate','numbertitle','off');hold on;grid on;
% plot(t,hip_x,t,hip_x_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('hip x (mm)');
% legend('filtered','Fourier series fit','location','best');
% %% HIP Y
% figure('name','Hip y coordinate','numbertitle','off');hold on;grid on;
% plot(t,hip_y,t,hip_y_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('hip y (mm)');
% legend('filtered','Fourier series fit','location','best');
% 
% %% KNEE X
% figure('name','Knee x coordinate','numbertitle','off');hold on;grid on;
% plot(t,knee_xr/100,t,knee_x,t,knee_x_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('knee x (mm)');
% legend('raw','filtered','Fourier series fit','location','best');
% %% KNEE Y
% figure('name','Knee y coordinate','numbertitle','off');hold on;grid on;
% plot(t,knee_yr/100,t,knee_y,t,knee_y_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('knee y (mm)');
% legend('raw','filtered','Fourier series fit','location','best');
% 
% %% KNEE X
% figure('name','Knee x acceleration','numbertitle','off');hold on;grid on;
% plot(t,knee_ax,t,knee_ax_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('knee a_x (m/s^2)');
% legend('Filtered','Fourier series fit','location','best');
% %% KNEE Y
% figure('name','Knee y acceleration','numbertitle','off');hold on;grid on;
% plot(t,knee_ay,t,knee_ay_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('knee a_y (m/s^2)');
% legend('filtered','Fourier series fit','location','best');
%  
% %% FIBULA X
% figure('name','Fibula x coordinate','numbertitle','off');hold on;grid on;
% plot(t,fibula_x,t,fibula_x_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('fibula x (mm)');
% legend('filtered','Fourier series fit','location','best');
% %% FIBULA Y
% figure('name','Fibula y coordinate','numbertitle','off');hold on;grid on;
% plot(t,fibula_y,t,fibula_y_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('fibula y (mm)');
% legend('filtered','Fourier series fit','location','best');
% 
% %% ANKLE X
% figure('name','Ankle x coordinate','numbertitle','off');hold on;grid on;
% plot(t,ankle_x,t,ankle_x_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('ankle x (mm)');
% legend('filtered','Fourier series fit','location','best');
% %% ANKLE Y
% figure('name','Ankle y coordinate','numbertitle','off');hold on;grid on;
% plot(t,ankle_y,t,ankle_y_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('ankle y (mm)');
% legend('filtered','Fourier series fit','location','best');
% 
% %% HEEL X
% figure('name','Heel x coordinate','numbertitle','off');hold on;grid on;
% plot(t,heel_x,t,heel_x_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('heel x (mm)');
% legend('filtered','Fourier series fit','location','best');
% %% HEEL Y
% figure('name','Heel y coordinate','numbertitle','off');hold on;grid on;
% plot(t,heel_y,t,heel_y_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('heel y (mm)');
% legend('filtered','Fourier series fit','location','best');
% 
% %% METATARSAL X
% figure('name','Metat x coordinate','numbertitle','off');hold on;grid on;
% plot(t,metat_x,t,metat_x_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('metat x (mm)');
% legend('filtered','Fourier series fit','location','best');
% %% METATARSAL Y
% figure('name','Metat y coordinate','numbertitle','off');hold on;grid on;
% plot(t,metat_y,t,metat_y_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('metat y (mm)');
% legend('filtered','Fourier series fit','location','best');
% 
% %% TOE X
% figure('name','Toe x coordinate','numbertitle','off');hold on;grid on;
% plot(t,toe_x,t,toe_x_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('toe x (mm)');
% legend('filtered','Fourier series fit','location','best');
% %% TOE Y
% figure('name','Toe y coordinate','numbertitle','off');hold on;grid on;
% plot(t,toe_y,t,toe_y_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('toe y (mm)');
% legend('filtered','Fourier series fit','location','best');
% 
% %% ANGLES
% %% A3
% figure('name','Foot Angle','numbertitle','off');hold on;grid on;
% plot(t,foot_theta,t,foot_theta_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('foot angle (degrees)');
% legend('filtered','Fourier series fit','location','best');
% 
% figure('name','Leg Angle','numbertitle','off');hold on;grid on;
% plot(t,leg_theta,t,leg_theta_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('leg angle (degrees)');
% legend('filtered','Fourier series fit','location','best');
% 
% figure('name','Thigh Angle','numbertitle','off');hold on;grid on;
% plot(t,thigh_theta,t,thigh_theta_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('thigh angle (degrees)');
% legend('filtered','Fourier series fit','location','best');
% 
% figure('name','HAT 1/2 Angle','numbertitle','off');hold on;grid on;
% plot(t,HAT_theta,t,HAT_theta_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('HAT 1/2 angle (degrees)');
% legend('filtered','Fourier series fit','location','best');
% % A4
% figure('name','Hip Angle','numbertitle','off');hold on;grid on;
% plot(t,hip_theta,t,hip_theta_f,'linewidth',1.5);
% xlabel('t (s)');ylabel('Hip angle (degrees)');
% legend('filtered','Fourier series fit','location','best');
% 
% figure('name','Knee Angle','numbertitle','off');hold on;grid on;
% plot(t,knee_theta,'k-',t,knee_theta_f,'r-','linewidth',1.5);
% xlabel('Time (s)');ylabel('Knee angle (\circ)');
% legend('filtered','Fourier series fit','location','best');
% 
% figure('name','Ankle Angle','numbertitle','off');hold on;grid on;
% plot(t,ankle_theta,'k-',t,ankle_theta_f,'r-','linewidth',1.5);
% xlabel('Time (s)');ylabel('Ankle angle (\circ)');
% legend('filtered','Fourier series fit','location','best');
% 
% figure('name','Ground Reaction Force x','numbertitle','off');hold on;grid on;
% plot(t,F_foot_ground_x,'k-','linewidth',1.5);
% xlabel('Time (s)');ylabel('Ground Reaction Force in x direction (N)');
% legend('filtered','location','best');
% 
% figure('name','Ground Reaction Force y','numbertitle','off');hold on;grid on;
% plot(t,F_foot_ground_y,'k-','linewidth',1.5);
% xlabel('Time (s)');ylabel('Ground Reaction Force in y direction (N)');
% legend('filtered','location','best');
% 
% figure('name','Ankle Force x','numbertitle','off');hold on;grid on;
% plot(t,F_foot_ankle_x,'linewidth',1.5);
% xlabel('t (s)');ylabel('Ankle Force x (N)');
% legend('filtered','location','best');
% 
% figure('name','Ankle Force y','numbertitle','off');hold on;grid on;
% plot(t,F_foot_ankle_y,'linewidth',1.5);
% xlabel('t (s)');ylabel('Ankle Force y (N)');
% legend('filtered','location','best');
% 
% figure('name','Ankle Moment','numbertitle','off');hold on;grid on;
% plot(t,M_foot_ankle,'linewidth',1.5);
% xlabel('t (s)');ylabel('Ankle Moment (N*m)');
% legend('filtered','location','best');
%% ANGULAR VELOCITIES
figure('name','Leg Angular Velocity','numbertitle','off');hold on;grid on;
plot(t,leg_omega,t,leg_omega_f,'linewidth',1.5);
xlabel('t (s)');ylabel('leg_omega (rad/s)');
legend('filtered','Fourier series fit','location','best');