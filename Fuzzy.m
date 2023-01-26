clc;
clear;
close all;

r = 23.529*1e-3;
a = 180.004*1e-3;

load('v_piston.mat');
load('gait_cycle_data.mat','knee_theta');
load('strain.mat');
data1 = xlsread('knee_moment.xlsx');
data2 = xlsread('knee_omega.xlsx');
knee_moment = data1(:,14);
knee_omega = data2(:,7);
knee_damping = knee_moment./knee_omega;
v_piston = transpose(v_piston);

knee_theta = 104-knee_theta;

s = sqrt(r^2+a^2-2*a*r*cosd(90-knee_theta));
piston_theta = acosd((r^2+a^2-s.^2)/(2*a*r));

piston_force = knee_moment./(r*cosd(piston_theta).*sind(knee_theta));
damping_coefficient = piston_force./v_piston;

fisdata = horzcat(knee_theta,v_piston,strain,damping_coefficient);

opt = anfisOptions('InitialFIS',4,'EpochNumber',500);

[fis,trainError] = anfis(fisdata,opt);