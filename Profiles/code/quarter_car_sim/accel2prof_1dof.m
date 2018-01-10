% Simulate quarter-car suspension model. Model used originally
% for an optimization demonstration in ME 149, Engineering System Design
% Optimization, a graduate course taught at Tufts University in the
% Mechanical Engineering Department. 


% Clear workspace
clear;

% accel data file location
dat_dir = 'C:\Users\John\Projects_Git\I76\Profiles\accel_data';
dat_name = 'truck_accel_run6.mat';
chan = 1;
fs = 200; % sampling frequency (Hz)

%vehicle model parameters
k = 33000;     %Suspension stiffness (lb/in)
c = 400;       %Suspension damping coefficient (lb-s/in)
  
ms = 48000;               % 1/4 sprung mass (lb)
mus = 5000;               % 1/4 unsprung mass (lb)
kus = 200000;          % tire stiffness (lb/in)
grav = 386.09;            % acceleration of gravity (in/s^2)
v = 800;                 % vehicle velocity (in/s)
dt = 0.005;             % simulation time step 
dx = 5;              % desired spacial step (in)

dt2 = dx/v;              % time step for each spatial step

x0 = [0 0 0 0]';                        % initial state    

% convert weight to mass
mus = mus/grav;
ms = ms/grav;
                        
% Construct linear state space model 
Aqcar = [0 1; -k/ms -c/ms];
Bqcar = [-1 0 0 0]'; 
Cqcar = [1 0; 0 1]; 
Dqcar = 0;

% create qcar object and assign
truck = qcar();
truck.ssmodel = ss(Aqcar,Bqcar,Cqcar,Dqcar);


% note: y(:,1-4) = x, y(:,5) = d/dt susp stroke (i.e., x3dot)
% Definition of System States:
% x(3) = z2-z1 = L2     suspension stroke (deflection)
% x(4) = z2dot          sprung mass velocity


% load accel data to match
datf = file();
datf.name = dat_name;
datf.path = dat_dir;
load(datf.fullname);
dat_accel = dat(:,chan)*grav; % convert g's to in/sec^2

%% Set up time and accel vectors
% time vectors for data
dt_sample = 1/fs;
t_end_sample = (length(dat_accel)-1)*dt_sample;
time_sample = 0:dt_sample:t_end_sample;
% resampled time vectors
dt_sim = dt2;
t = 0:dt_sim:t_end_sample;
%sample data to match simulation dt
accel_match = interp1(time_sample, dat_accel, t)';
% plot original and resampled accel to compare
figure
plot(time_sample,dat_accel)
hold all 
plot(t,accel_match)

%% Set optimization options
% bounds
LB = -5;
UB = 5;
start0 = 0;
% options
algOpt = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective',...
                'TolFun',1e-12,...
                'TolX',1e-4,...
                'Display','final');
            
%% initialize initial conditions
% state initial conditions
x0_dt = x0;
% starting profile 1st point
u0 = 0;
v0 = 0;
uu(1) = u0;
% value bounds
lb = LB; ub = UB; start = start0;
% assign time vector to object (single step)
truck.time = [0 dt_sim];

% number of time steps in simuation
time_steps = length(vel_match); 


%run through simulation step by step
for ii=1:10%time_steps
    % populate qcar object
    truck.x0 = x0_dt;      
    % create anonymous function that generates the data (residuals) to minimize
    obj = @(para)sim_car_obj(para,truck,vel_match(ii));
    
    %% run optimization    
    [x,resnorm,residual,exitflag,output] = lsqnonlin(obj,start,lb,ub,algOpt);
    
    %% replace intial conditions with final states
    truck.profile = [x 0];
    % run qcar simulation for given profile step
    yy = truck.simulate;
    
    % advance
    x0_dt = yy(end,1:4);
%     v0 = diff([u0 x])/dt_sim;
    u0 = x;
    start = x;
    % store values to profile
    uu(ii) = x;
    % store state values
    vel_out(ii) = yy(end,4);
end

% convert velocity values to displacement
%prof = cumtrapz(vv)*dt;
