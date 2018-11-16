
% Clear workspace
clear;

%% vehicle parameters
% Spring stiffness
k = 40 *175.127E3; %k/in to N/m
% Viscocity coefficient
c = 305.66 *175.127; %lbf-s/in to N.s/m
  
ms = 46*453.592;               % 1/4 sprung mass (kip to kg)
mus = 2*453.592;               % 1/4 unsprung mass (kip to kg)
kus = 80*175.127E3;          % tire stiffness (k/in to N/m)
grav = 9.81;            % acceleration of gravity (m/s^2)
v = 715*0.0254;                % vehicle velocity (in/sec to m/s)
% dt = 0.005;             % simulation time step  

% Construct linear state space model 
Aqcar = [0 1 0 0;-kus/mus -c/mus k/mus c/mus;0 -1 0 1;0 c/ms -k/ms -c/ms];
Bqcar = [-1 0 0 0]'; 
Cqcar = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; 0 -1 0 1]; 
Dqcar = 0;
x0 = [0 0 0 0]';

%% Load profile
pro_file = file();
pro_file.name = 'EB_Right_1_R.csv';
pro_file.path = 'C:\Users\John\Projects_Git\DAmp\I76\Profiles\measured\for_simulation\EB_right';
file_cont = dlmread(pro_file.fullname,',');
profile = file_cont(:,2)*0.0254; %convert inches to meters


%% Form quarter car state model
dx = max(diff(file_cont(1:2,1)));
x = (0:dx:(length(file_cont)-1)*dx)*0.0254; % profile location steps in meters
t = x/v; % time steps
dt = t(2);

truck = qcar();
truck.ssmodel = ss(Aqcar,Bqcar,Cqcar,Dqcar);
truck.profile = [0; diff(profile)/dt];
truck.time = t;
% simulate
yy = truck.simulate;

%% Convert to acceleration
vel = yy(:,4);
accel = [0; diff(vel)/dt]/grav; %(m/sec^2 to g)


