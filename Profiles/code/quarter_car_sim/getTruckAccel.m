
%% Load Data
load('F:\I76\I76\data\6.28.17\bridge+truck.mat')
saveloc = 'C:\Users\John\Projects_Git\I76\Profiles\accel_data';
run_num =6;

dat_t = dat_truck{run_num};

%filter out high frequency content
fs = 1652;
forder = 6; % Order of filter function
rip = 0.5; % Pass band ripple
atten_stop = 40; % Stop attenuation in dB
flim = 20; % Frequency pass upper limit
[b,a] = ellip(forder,rip, atten_stop, flim/(fs/2),'low');
% freqz(b,a,32000,fs)

% Apply filter
fdat_t = filter(b,a,dat_t);

%Plot filtered data
figure
plot(fdat_t(:,2:5))

%choose start and stop indices
lim_1 = 24612;
lim_2 = length(fdat_t);
% choose accel channel
chans = [3 5]; % driver rear, pass rear

% extract only accel records of interest
dat = fdat_t(lim_1:lim_2,chans);

plot(dat)

% save extracted data to file
save([saveloc '\truck_accel_run' num2str(run_num) '.mat'],'dat');
