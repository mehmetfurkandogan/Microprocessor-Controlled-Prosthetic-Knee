%  Forces on strain gauges
% 09.12.22
clc;clear;close all;
%% IMPORT DATA
load('gait_cycle_data.mat','T','t','leg_theta','F_foot_ankle_x',...
    'F_foot_ankle_y','F_foot_ground_x','F_foot_ground_y','M_foot_ankle');

%% COORDINATE TRANSFORMATION
theta = leg_theta - 90; % degree

F_foot_ankle = zeros(2,size(t,1));
for i = 1:size(t,1)
    F_foot_ankle(:,i) = [F_foot_ankle_x(i);
                    F_foot_ankle_y(i)];
    R = [cosd(theta(i)) -sind(theta(i));
        sind(theta(i)) cosd(theta(i))];
    F_foot_ankle(:,i) = R * F_foot_ankle(:,i);           
end


L_sg = 50e-3:0.1e-3:100e-3;   % m
max_strain_L = zeros(1,size(L_sg,2));
min_SF_L = zeros(1,size(L_sg,2));
for i = 1:size(L_sg,2)
    [max_strain_L(i),min_SF_L(i),~,~] = strain_gauge(F_foot_ankle,M_foot_ankle,L_sg(i));
    % max_strain_L(i) = max_strain;
    % min_SF_L(i) = min_SF;
end

% figure();
% hold on; grid on;
% plot(L_sg*1e3,max_strain_L*1e6,'k-','linewidth',1.5);
% ylabel('Strain (\mu m / m)'); xlabel('Strain gauge distance(mm)');

% figure();
% hold on; grid on;
% plot(L_sg*1e3,min_SF_L,'k-','linewidth',1.5);
% ylabel('Safety Factor'); xlabel('Strain gauge distance(mm)');
% 
L_sg = 72e-3;     % m
[max_strain,min_SF,strain1,strain2] = strain_gauge(F_foot_ankle,M_foot_ankle,L_sg);

strain = strain2 - strain1;

figure();hold on;grid on;
plot(t,strain1*1e6,'k-',t,strain2*1e6,'r-','linewidth',1.5);
legend('1^{st} Strain Gauge','2^{nd} Strain Gauge');
xlabel('t (s)');ylabel('Strain (\mu m/m)');
Ti = 0.37; % 27. eleman
t = t(1:70);
t = (t-t(1)).*100/T;

strain1 = [strain1(27:end);strain1(1:26)];
strain2 = [strain2(27:end);strain2(1:26)];

strain1 = strain1(1:70);
strain2 = strain2(1:70);

strain_M = strain2-strain1;
strain_A = strain2+strain1;


figure();hold on;grid on;
plot(t,strain_A*1e6,'k-',t,strain_M*1e6,'r-','linewidth',1.5);

xlabel('% gait cycle');ylabel('Strain (\mu m/m)');
plot([10 10],[-150 250],'k--');
plot([30 30],[-150 250],'k--');
plot([50 50],[-150 250],'k--');
plot([60 60],[-150 250],'k--');
plot([73 73],[-150 250],'k--');
plot([87 87],[-150 250],'k--');
% legend('Axial Output','Moment Output');
% 
% fprintf('Minimum Safety Factor: %.3f\n',min_SF);
% fprintf('Maximum Strain: %.3f um/m\n',max_strain*10^6);
