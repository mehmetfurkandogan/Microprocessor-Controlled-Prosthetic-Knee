%% Prosthetic Simulation
% Mehmet Furkan Doğan
% 14.01.2023
clc;clear;close all;
%% LOADING DATA
load('gait_cycle_data.mat','T');
%% CALCULATIONS
tinc = 0.01; % time increment
N = 1;  % Number of steps
tr = 0:tinc:N*T;            % time for right leg (actual time)
tl = -T/2:tinc:N*T-T/2;     % time for left leg 
% tl is defined to add phase difference between legs (90 degrees)
% Right Leg
cd("Position Functions\");
rib_xr = rib_x(tr);
rib_yr = rib_y(tr);
hip_xr = hip_x(tr);
hip_yr = hip_y(tr);
knee_xr = knee_x(tr);
knee_yr = knee_y(tr);
fibula_xr = fibula_x(tr);
fibula_yr = fibula_y(tr);
ankle_xr = ankle_x(tr);
ankle_yr = ankle_y(tr);
heel_xr = heel_x(tr);
heel_yr = heel_y(tr);
metat_xr = metat_x(tr);
metat_yr = metat_y(tr);
toe_xr = toe_x(tr);
toe_yr = toe_y(tr);
% Left Leg
rib_xl = rib_x(tl);
rib_yl = rib_y(tl);
hip_xl = hip_x(tl);
hip_yl = hip_y(tl);
knee_xl = knee_x(tl);
knee_yl = knee_y(tl);
fibula_xl = fibula_x(tl);
fibula_yl = fibula_y(tl);
ankle_xl = ankle_x(tl);
ankle_yl = ankle_y(tl);
heel_xl = heel_x(tl);
heel_yl = heel_y(tl);
metat_xl = metat_x(tl);
metat_yl = metat_y(tl);
toe_xl = toe_x(tl);
toe_yl = toe_y(tl);
cd("..");
%% PLOTTING
f = figure('name','Gait Cycle','numberTitle','off');
hold on;
set(gca,'NextPlot','replacechildren','DataAspectRatio',[1 1 1]);
xmin=-100;xmax = 2200;
ymin=0;ymax = 1200;
xlim([xmin xmax]);ylim([ymin ymax]);

color_r = [102,194,165]/255;
color_l = [252,141,98]/255;

for i = [size(tr,1),size(tr,2)]
    % RIGHT
    HAT1_2_xr = [rib_xr(i),hip_xr(i)];
    HAT1_2_yr = [rib_yr(i),hip_yr(i)];
    Thigh_xr = [hip_xr(i),knee_xr(i)];
    Thigh_yr = [hip_yr(i),knee_yr(i)];
    Leg_xr = [fibula_xr(i),ankle_xr(i)];
    Leg_yr = [fibula_yr(i),ankle_yr(i)];
    Foot_xr = [ankle_xr(i),heel_xr(i),metat_xr(i),ankle_xr(i)];
    Foot_yr = [ankle_yr(i),heel_yr(i),metat_yr(i),ankle_yr(i)];
    Foot2_xr = [metat_xr(i),toe_xr(i)];
    Foot2_yr = [metat_yr(i),toe_yr(i)];
    % LEFT
    deltax = rib_xr(i) - rib_xl(i);
    HAT1_2_xl = [rib_xl(i)+deltax,hip_xl(i)+deltax];
    HAT1_2_yl = [rib_yl(i),hip_yl(i)];
    Thigh_xl = [hip_xl(i)+deltax,knee_xl(i)+deltax];
    Thigh_yl = [hip_yl(i),knee_yl(i)];
    Leg_xl = [fibula_xl(i)+deltax,ankle_xl(i)+deltax];
    Leg_yl = [fibula_yl(i),ankle_yl(i)];
    Foot_xl = [ankle_xl(i)+deltax,heel_xl(i)+deltax,metat_xl(i)+deltax,ankle_xl(i)+deltax];
    Foot_yl = [ankle_yl(i),heel_yl(i),metat_yl(i),ankle_yl(i)];
    Foot2_xl = [metat_xl(i)+deltax,toe_xl(i)+deltax];
    Foot2_yl = [metat_yl(i),toe_yl(i)];

%     clf
%     set(gca,'NextPlot','replacechildren','DataAspectRatio',[1 1 1]);
    xlim([xmin xmax]);ylim([ymin ymax]);
    grid on;
    hold on;
    % Right Leg
    plot(HAT1_2_xr,HAT1_2_yr,Thigh_xr,Thigh_yr,...
        'linewidth',1.5,'Color',color_r);
    % Right Knee
    plot(knee_xr(i),knee_yr(i),'o','Color',color_r,'MarkerFaceColor',color_r);
    % Right Fibula and Foot
    plot(Leg_xr,Leg_yr,Foot_xr,Foot_yr,Foot2_xr,Foot2_yr,...
        'linewidth',1.5,'Color',color_r);
    
    % Left Leg
    plot(HAT1_2_xl,HAT1_2_yl,Thigh_xl,Thigh_yl,Leg_xl,Leg_yl,Foot_xl,...
        Foot_yl,Foot2_xl,Foot2_yl,'linewidth',1.5,'Color',color_l);
    
    % legend
    
    
    drawnow
end
% movie(F2,1,1/tinc);
