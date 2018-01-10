function obj = sim_car_obj2(para,optrun,vel,prev_prof,prev_slope)

% para - next point/s in profile
% optrun - qcar object
% accel - acceleration for time/s simulated to be compared
% u0    - elevation of previous point if profile

% set up velocity profile
dt = diff(optrun.time(1:2));
optrun.profile = [para 0];

% run qcar simulation for given profile step
yy = optrun.simulate;

% % compute acceleration
% 
% sim_accel = diff(yy(1:2,4))'/dt;
vel_sim = yy(2,4);

% compare with given velocity
obj(1) = (vel_sim-vel);
obj(2) = ((para-prev_prof)-prev_slope)*.5;


