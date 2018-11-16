%load accel data
load('F:\I76\I76\data\6.28.17\bridge+truck.mat')

dof_legend = {'Driver Front'... 
                'Driver Rear'...
                'Passenger Front'...
                'Passenger Rear'};
%plot truck acceleration vs location



tick_labels(1:23) = {'|'};
span_labels(1:11) = {'Span-'};
span_nums = string(num2cell([1:11]));
span_labels = cellstr([char(span_labels') char(span_nums')]);
tick_labels(2:2:22) = span_labels;

%filter out high frequency content
fs = 1652;
forder = 6; % Order of filter function
rip = 0.5; % Pass band ripple
atten_stop = 40; % Stop attenuation in dB
flim = 10; % Frequency pass upper limit
[b,a] = ellip(forder,rip, atten_stop, flim/(fs/2),'low');
% freqz(b,a,32000,fs)

dt = 1/fs; %sec

%% Run 12
run_num = 12;


dat_filt = filter(b,a,dat_truck{run_num}(:,2:5));

fh = figure;
plot(dat_truck{run_num}(:,7));
enter_ind = 40000;
exit_ind = 147045;

plot(tst_truck{run_num}(enter_ind:end,1),dat_filt(enter_ind:end,:))
legend(dof_legend);

dat_file = file();
dat_file.name =['run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat_filt(enter_ind:end,2),'delimiter','\t','precision',6);

%% Run 6
run_num = 6;


dat_filt = filter(b,a,dat_truck{run_num}(:,2:5));

fh = figure;
plot(dat_truck{run_num}(:,7));
enter_ind = 60000;

plot(tst_truck{run_num}(enter_ind:end,1),dat_filt(enter_ind:end,:))
legend(dof_legend);

dat_file = file();
dat_file.name =['run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat_filt(enter_ind:end,2),'delimiter','\t','precision',6);

plot(tst_truck{run_num}(enter_ind:end,1),[dat_filt(enter_ind:end,2) dat_truck{run_num}(enter_ind:end,3)])
%% Run 14
run_num = 14;


dat_filt = filter(b,a,dat_truck{run_num}(:,2:5));

fh = figure;
plot(dat_truck{run_num}(:,7));
enter_ind = 80000;

plot(tst_truck{run_num}(enter_ind:end,1),dat_filt(enter_ind:end,:))
legend(dof_legend);

dat_file = file();
dat_file.name =['run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat_filt(enter_ind:end,2),'delimiter','\t','precision',6);

%% Run 9
run_num = 9;

dat_filt = filter(b,a,dat_truck{run_num}(:,2:5));

fh = figure;
plot(dat_truck{run_num}(:,7));
enter_ind = 1;

plot(tst_truck{run_num}(enter_ind:end,1),dat_filt(enter_ind:end,:))
legend(dof_legend);

dat_file = file();
dat_file.name =['run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat_filt(enter_ind:end,2),'delimiter','\t','precision',6);

%% Run 3
run_num = 3;

dat_filt = filter(b,a,dat_truck{run_num}(:,2:5));

fh = figure;
plot(dat_truck{run_num}(:,7));
enter_ind = 150000;

plot(tst_truck{run_num}(enter_ind:end,1),dat_filt(enter_ind:end,:))
legend(dof_legend);

dat_file = file();
dat_file.name =['run-' num2str(run_num) '.txt'];

dat_file.path = 'C:\Users\John\Projects_Git\I76\sim_responses\exp_resp';
dlmwrite(dat_file.fullname,dat_filt(enter_ind:end,2),'delimiter','\t','precision',6);
