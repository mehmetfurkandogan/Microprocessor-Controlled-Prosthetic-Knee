clc;
clear;
close all;

r = 23.529*1e-3;
a = 180.004*1e-3;

load('v_piston.mat');
load('gait_cycle_data.mat','knee_theta','t','F_foot_ground_y');
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
knee_theta = 104-knee_theta;

X = horzcat(knee_theta,F_foot_ground_y,v_piston);
Y = damping_coefficient;

% t1 = t(46:71,:);
% t2 = t(1:45,:);
% t = [t1;t2];
t = t(1:71);

trnX = X(1:2:end,:); % Training input data set
trnY = Y(1:2:end,:); % Training output data set
vldX = X(2:2:end,:); % Validation input data set
vldY = Y(2:2:end,:); % Validation output data set

X1 = X(43:71,:);
X2 = X(1:42,:);
X = [X1;X2];
Y1 = Y(43:71,:);
Y2 = Y(1:42,:);
Y = [Y1;Y2];

data = horzcat(X,Y);

plot(t, X(:,1));

dataRange = [min(data)' max(data)'];

options = genfisOptions('GridPartition');
options.NumMembershipFunctions = 3;
fisin = mamfis;
rng('default')
fisin = addInput(fisin,dataRange(1,:),'Name','Angle','NumMFs',3);
fisin = addInput(fisin,dataRange(2,:),'Name','Strain','NumMFs',3);
fisin = addInput(fisin,dataRange(3,:),'Name','Velocity','NumMFs',3);
fisin = addOutput(fisin,[min(t) max(t)],'Name','Damping Coefficient','NumMFs',27);

% figure
% plotfis(fisin)

options = tunefisOptions('Method','particleswarm',...
 'OptimizationType','learning', ...
 'NumMaxRules',27);
options.MethodOptions.MaxIterations = 10;
rng('default')
fisout1 = tunefis(fisin,[],X,t,options);

%plotActualAndExpectedResultsWithRMSE(fisout1,vldX,vldY);

% tuningOpt = tunefisOptions;
% tuningOpt.MethodOptions.MaxGenerations = 30;
% tuningOpt.KFoldValue = 3;
% tuningOpt.ValidationWindowSize = 2;
% tuningOpt.ValidationTolerance = 0.05;

[in,out,rule] = getTunableSettings(fisout1);
% options.Method = 'patternsearch';
options = tunefisOptions('Method',"patternsearch");
options.OptimizationType = 'tuning';
options.MethodOptions.MaxIterations = 900;
rng('default')
fisout = tunefis(fisout1,[in;out;rule],X,t,options);
% 
% figure
% plotfis(fisout)
