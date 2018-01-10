%vehicle velocity
vel = 800; %in/sec
dx = 4; %in
dt = dx/vel;

dist = 0:dx:500*12;
t = dist/vel;

% number of sinusoidal signals to sum
ns = 10;
% range of periods ft
rp = [5 55];
periods_l = (diff(rp)*rand(ns,1)+rp(1))*12;
periods_t = periods_l/vel;

% range of amplitudes (in)
ra = [.05 .5];
amps = diff(ra)*rand(ns,1)+ra(1);

%phase
phases = rand(1,ns);

%sum together signals
for ii = 1:ns
    prof_d(ii,:) = amps(ii)*sin(2*pi*(periods_l(ii)^(-1))*dist+phases(ii)*10);
    prof_t(ii,:) = amps(ii)*sin(2*pi*(periods_t(ii)^(-1))*t+phases(ii)*10);
end

profile_d = sum(prof_d,1);
profile_t = sum(prof_t,1);

profile_vel = diff(profile_t)/dt;

profile = profile_vel;

figure
plot(profile);