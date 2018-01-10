% Load profile
load('C:\Users\John\Projects_Git\I76\Profiles\code\profile_EB_right_1.mat')

%% compute fft
dx = dd(2)-dd(1);
fs = 1/dx;
ll = length(prof);
yy = fft(prof);

p2 = abs(yy/ll);
p1 = p2(1:ll/2+1);
p1(2:end-1) = 2*p1(2:end-1);

ff = fs*(0:ll/2)/ll;
figure
ah = axes;
plot(ff,p1);
xlims = [0 0.1];
xlim(xlims);

tick_labels = string(num2cell(round(1./[0:0.01:.1],1)));
tick_labels(1) = ' ';
ah.XTickLabel = tick_labels;
xlabel('Wavelength (ft)');
ylabel('(in.)');

% zoom in on region
xlim([1/60 1/20])
ylim([0 .1]);
ah.XTickLabel = string(num2cell(round(1./(0.02:.005:0.05))));

%% try psd
addpath(genpath('C:\Users\John\Projects_Git\vma'))

%percOverlap = 50;

window = 500;          % window length for nAvg
noverlap = 200;   % overlap length for averaging
[pxx,f] = pwelch(prof,window,noverlap,500,fs);

figure
plot(f,mag2db(pxx))