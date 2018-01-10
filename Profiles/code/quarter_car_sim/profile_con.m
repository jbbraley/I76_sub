function [c, ceq] = profile_con(x,lim,n,prev_x)
% a smoothness check of the points
if nargin<4
    prev_x = [];
end

dd = 0:(n-1);
points = polyval(x,dd);
    
data = [prev_x points];

%% Goodnes of fit
% [~, r_squar] = fit([1:length(data)]',data','poly4');
% c(1) = r_squar.rmse-lim(1);

%% Max slope
% c(2) = max(abs(diff(data)))-lim(2);

% max value
c(1) = max(data)-lim(1);
% min value
c(2) = abs(min(data))-lim(1);

%% Max change in slope
% c(3) = max(abs(diff(diff(data))))-lim(2);
ceq = [];
