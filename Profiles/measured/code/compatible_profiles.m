% load profile text file
dat_name = 'WB_right_2.txt';

% wheel line
line = 1;
% location of bridge start for specific profile
start_station = 489.8;
% distance of model vehicle travel before bridge start
prepro_length = 450;
% specify distance of ramp to start profile
ramp_length = 20; 
%converted filename
pro_file_name = 'WB_right_2_L.csv';

%index appropriate profile
dist_ind = 2*line-1;
elev_ind = 2*line;

%load profile data
dat_file = file();
dat_file.name = dat_name;
dat_file.path = 'C:\Users\John\Projects_Git\I76\Profiles\measured\profiles';
prof1 = dlmread(dat_file.fullname, '\t',1,0);

% find bridge start location index
start_ind = find(prof1(:,dist_ind)-start_station<0,1,'last');

%index intended beginning of profile data
prof_start = find(prof1(:,dist_ind)-(start_station-prepro_length)<0,1,'last')+1;

% trim profile to finish at bridge end
% total_length = 1441*12+8;
% prof_end = find(prof1(:,1)-(start_station-prepro_length/12)<0,1,'last');

% reset distance vector to have zero station at profile beginning and
% convert to inches
dist = (prof1(prof_start:end,dist_ind)-prof1(prof_start,dist_ind))*12;

% ramp up start of profile from 0 over 20'
dd = diff(prof1(1:2,dist_ind));

ramp_ind = floor(ramp_length/dd);
elev = prof1(prof_start:end,elev_ind);
elev(1:ramp_ind) = linspace(0, 1,ramp_ind)'.*elev(1:ramp_ind);

% create profile text file for simulation purposes
pro_file = file();
pro_file.name =pro_file_name;

pro_file.path = 'C:\Users\John\Projects_Git\I76\Profiles\measured\for_simulation';
dlmwrite(pro_file.fullname,[dist elev],'delimiter',',','precision',6);