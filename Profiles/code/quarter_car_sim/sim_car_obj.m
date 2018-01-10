function obj = sim_car_obj(para,optrun,vel)

% para - next point/s in profile
% optrun - qcar object
% accel - acceleration for time/s simulated to be compared
% u0    - elevation of previous point if profile

% create points from function
n = length(vel);
d = 0:n-1;

% polynomial evaluation
x(1:n) = polyval(para,d);

% set up velocity profile
% dt = diff(optrun.time(1:2));
optrun.profile = [x 0];
% steps = length(para);
% run qcar simulation for given profile step
yy = optrun.simulate;

% % compute acceleration
% 
% sim_accel = diff(yy(1:2,4))'/dt;
vel_sim = yy(2:end,4);

% compare with given velocity
for ii = 1:length(vel_sim)
    diff(ii) = (vel_sim(ii)-vel(ii));
end

% % add rsm to objectives (minimal profile)
% diff(end+1) = rms(para)*.1;

% take root of sum of squares
obj = rssq(diff);

