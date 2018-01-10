% simulate sprung mass response to variable raod profile (quarter-car
% model)

k = 150000; % stiffness of vehicle suspension
dampR = 0.5;
c = dampR*(2*sqrt(k*ms));

c = 1120; % suspension damping
ms = 275;               % 1/4 sprung mass (kg)
mus = 27;               % 1/4 unsprung mass (kg)
kus = 310000;          % tire stiffness (N/m)
cu = 3100;              % tire damping
grav = 9.81;            % acceleration of gravity (m/s^2)
v = 10;                 % vehicle velocity (m/s)
dt = 0.01;             % simulation time step  

% create state space model
Aqcar = [0 0 0 1; 0 0 1 -1; 0 -k/ms -c/ms c/ms; -kus/mus k/mus c/mus -(c+cu)/mus];
Bqcar = [cu/mus; -cu/mus; c*cu/(ms*mus); -c*cu/mus^2-cu^2/mus^2+kus/mus]; 
Cqcar = [1 1 0 0; 0 0 1 0; 1 0 0 0; 0 0 0 1; 0 1 0 0]; 
Dqcar = 0;
qcar = ss(Aqcar,Bqcar,Cqcar,Dqcar);

t=0:0.01:10;
u=0.1*ones(size(t));
[Y,X] = lsim(Aqcar,Bqcar,Cqcar,Dqcar,u,t);
plot(t,Y)

% Sprung mass displacement
disp_sim = Y(:,1);
% sprung mass acceleration
accel_sim = [0; diff(Y(:,2))/dt];

plot(t,accel_sim)