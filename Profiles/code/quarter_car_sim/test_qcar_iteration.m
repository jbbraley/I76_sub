load('test_accel.mat')
dt = 0.005;
x0 = [0 0 0 0]';
profile = [0 diff(prof)/dt];

t_end_sample = (length(profile)-1)*dt;
t = 0:dt:t_end_sample;

truck = qcar();
truck.ssmodel = ss(Aqcar,Bqcar,Cqcar,Dqcar);


x0_dt = x0;

for ii=1:length(profile)
    % populate qcar object
    truck.x0 = x0_dt; 
    truck.profile = [profile(ii) 0];
    truck.time = t(1:2);
    yy2 = truck.simulate;
    
%     % create anonymous function that generates the data (residuals) to minimize
%     obj = @(para)sim_car_obj(para,truck,accel_match(ii),u0,v0);
%     
%     %% run optimization    
%     [x,resnorm,residual,exitflag,output] = lsqnonlin(obj,start,lb,ub,algOpt);
    
    %% replace intial conditions with final states
    % advance
    x0_dt = yy2(end,1:4);
    % store state values
    yy4(ii) = yy2(end,4);
end

vel_match = yy4;
dt_sim = dt;


truck.x0 = x0;
truck.profile = profile;
truck.time = t;
yy = truck.simulate;


