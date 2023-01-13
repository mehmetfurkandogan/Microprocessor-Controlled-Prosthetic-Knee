%% Gait Cycle Animation
% Mehmet Furkan Doğan
% 28 November 2022
clc;clear;close all;
%% IMPORT DATA
load('gait_cycle_data.mat','t','T','rib_x','rib_y','hip_x','hip_y','knee_x',...
    'knee_y','fibula_x','fibula_y','ankle_x','ankle_y','heel_x','heel_y',...
    'metat_x','metat_y','toe_x','toe_y');
rib_xd = rib_x;clear rib_x;
rib_yd = rib_y;clear rib_y;
hip_xd = hip_x;clear hip_x;
hip_yd = hip_y;clear hip_y;
knee_xd = knee_x;clear knee_x;
knee_yd = knee_y;clear knee_y;
fibula_xd = fibula_x;clear fibula_x;
fibula_yd = fibula_y;clear fibula_y;
ankle_xd = ankle_x;clear ankle_x;
ankle_yd = ankle_y;clear ankle_y;
heel_xd = heel_x;clear heel_x;
heel_yd = heel_y;clear heel_y;
metat_xd = metat_x;clear metat_x;
metat_yd = metat_y;clear metat_y;
toe_xd = toe_x;clear toe_x;
toe_yd = toe_y;clear toe_y;

%% CALCULATIONS
tinc = 0.01; % time increment
N = 7;  % Number of steps
tr = 0:tinc:N*T;            % time for right leg
tl = -T/2:tinc:N*T-T/2;     % time for left leg
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
%% INITIALIZING THE FIGURE
f1 = figure('name','Gait Cycle','numberTitle','off');
hold on;
set(gca,'NextPlot','replacechildren','DataAspectRatio',[1 1 1]);
xlim([0 3000]);ylim([0 1200]);
f1.Position = [2         476        1361         208];

f2 = figure('name','Gait Cycle','numberTitle','off');
hold on;
set(gca,'NextPlot','replacechildren','DataAspectRatio',[1 1 1]);
xlim([0 10000]);ylim([0 1200]);
f2.Position = [ 2          32        1364         358];
%% ANIMATION
% INITIALIZING THE VIDEO
v1 = VideoWriter('Animations\walking_data.avi');
v1.FrameRate = 1/0.0145;
v2 = VideoWriter('Animations\walking_extended.avi');
v2.FrameRate = 1/tinc;
open(v1);
open(v2);
% DATA
figure(f1);
for i = 1:size(t,1)
    HAT1_2_xr = [rib_xd(i),hip_xd(i)];
    HAT1_2_yr = [rib_yd(i),hip_yd(i)];
    Thigh_xr = [hip_xd(i),knee_xd(i)];
    Thigh_yr = [hip_yd(i),knee_yd(i)];
    Leg_xr = [fibula_xd(i),ankle_xd(i)];
    Leg_yr = [fibula_yd(i),ankle_yd(i)];
    Foot_xr = [ankle_xd(i),heel_xd(i),metat_xd(i),ankle_xd(i)];
    Foot_yr = [ankle_yd(i),heel_yd(i),metat_yd(i),ankle_yd(i)];
    Foot2_xr = [metat_xd(i),toe_xd(i)];
    Foot2_yr = [metat_yd(i),toe_yd(i)];
    plot(HAT1_2_xr,HAT1_2_yr,Thigh_xr,Thigh_yr,Leg_xr,Leg_yr,Foot_xr,Foot_yr,Foot2_xr,Foot2_yr,'linewidth',1.5);
    F1(i) = getframe(gcf);
    writeVideo(v1,F1(i));
    clf(f1)
    set(gca,'NextPlot','replacechildren','DataAspectRatio',[1 1 1]);
    xlim([0 3000]);ylim([0 1200]);
end
figure(f2);
for i = 1:size(tr,2)
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
    plot(HAT1_2_xr,HAT1_2_yr,Thigh_xr,Thigh_yr,Leg_xr,Leg_yr,Foot_xr,Foot_yr,Foot2_xr,Foot2_yr,'linewidth',1.5);
    hold on;
    plot(HAT1_2_xl,HAT1_2_yl,Thigh_xl,Thigh_yl,Leg_xl,Leg_yl,Foot_xl,Foot_yl,Foot2_xl,Foot2_yl,'linewidth',1.5);
    F2(i)  = getframe(gcf);
    writeVideo(v2,F2(i));
    clf(f2)
    set(gca,'NextPlot','replacechildren','DataAspectRatio',[1 1 1]);
    xlim([0 10000]);ylim([0 1200]);
end
figure(f1);
movie(F1,1,1/0.0145);
figure(f2);
movie(F2,1,1/tinc);
close(v1);
close(v2);
close all;