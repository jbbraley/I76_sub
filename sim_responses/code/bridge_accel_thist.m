%% Load data
load('F:\I76\I76\data\6.28.17\bridge+truck.mat')


% %filter out high frequency content
% fs = 1652;
% forder = 6; % Order of filter function
% rip = 0.5; % Pass band ripple
% atten_stop = 40; % Stop attenuation in dB
% flim = 10; % Frequency pass upper limit
% [b,a] = ellip(forder,rip, atten_stop, flim/(fs/2),'low');
% % freqz(b,a,32000,fs)
% 
% dt = 1/fs; %sec

%% Index specific channels for sensor locations of interest
% channels for sensors located at midspan of the corresponding exterior
% girders (i.e. G1,4,5,8)
EB_left_chan = [3 13 25 32 36];
EB_right_chan = [4 14 26 33];
WB_left_chan = [2 12 24 31 35];
WB_right_chan = [1 11 23 30];

% save portion of data to file for easy import into excel

%%Run 12
run_num = 12;
dat = dat_master{run_num}(:,EB_left_chan);

dat_file = file();
dat_file.name =['bridge-accel_run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat,'delimiter','\t','precision',6);

%%Run 6
run_num = 6;
dat = dat_master{run_num}(:,EB_left_chan);

dat_file = file();
dat_file.name =['bridge-accel_run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat,'delimiter','\t','precision',6);

%% Run 14
run_num = 14;
dat = dat_master{run_num}(:,EB_right_chan);

dat_file = file();
dat_file.name =['bridge-accel_run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat,'delimiter','\t','precision',6);

%% Run 3
run_num = 3;
dat = dat_master{run_num}(:,WB_right_chan);

dat_file = file();
dat_file.name =['bridge-accel_run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat,'delimiter','\t','precision',6);