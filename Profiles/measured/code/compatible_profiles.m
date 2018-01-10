% load profile text file
prof1 = dlmread('C:\Users\John\Projects_Git\I76\Profiles\measured\profiles\EB_right_1.txt', '\t',1,0);
lane = 2;

dist_ind = 2*lane-1;
elev_ind = 2*lane;

% find bridge start location
start_station = 517.6;
start_ind = find(prof1(:,dist_ind)-start_station<0,1,'last');

%adjust to specified lead up to bridge

dd = diff(prof1(1:2,dist_ind));
prepro_length = 500*12;
prof_start = find(prof1(:,dist_ind)-(start_station-prepro_length/12)<0,1,'last');

% trim profile to finish at bridge end
% total_length = 1441*12+8;
% prof_end = find(prof1(:,1)-(start_station-prepro_length/12)<0,1,'last');

% reset distance vector to have zero station at profile beginning and
% convert to inches
dist = (prof1(prof_start:end,dist_ind)-prof1(prof_start,dist_ind))*12;

% ramp up start of profile from 0 over 20'

ramp_length = 20; 
ramp_ind = floor(ramp_length/dd);
elev = prof1(prof_start:end,elev_ind);
elev(1:ramp_ind) = linspace(0, elev(ramp_ind),ramp_ind);

% create profile text file for simulation purposes
pro_file = file();
pro_file.name = 'EB_right_1_R_conv.csv';
pro_file.path = 'C:\Users\John\Projects_Git\I76\Profiles\measured';
dlmwrite(pro_file.fullname,[dist elev],'delimiter',',','precision',6);