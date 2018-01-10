% Simulate quarter-car suspension model. Model used originally
% for an optimization demonstration in ME 149, Engineering System Design
% Optimization, a graduate course taught at Tufts University in the
% Mechanical Engineering Department. 


% Clear workspace
clear;

k = 150000;
c = 1120;
  
ms = 275;               % 1/4 sprung mass (kg)
mus = 27;               % 1/4 unsprung mass (kg)
kus = 310000;          % tire stiffness (N/m)
grav = 9.81;            % acceleration of gravity (m/s^2)
v = 10;                 % vehicle velocity (m/s)
dt = 0.005;             % simulation time step  
                        
% Construct linear state space model 
Aqcar = [0 1 0 0;-kus/mus -c/mus k/mus c/mus;0 -1 0 1;0 c/ms -k/ms -c/ms];
Bqcar = [-1 0 0 0]'; 
Cqcar = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1; 0 -1 0 1]; 
Dqcar = 0;
qcar = ss(Aqcar,Bqcar,Cqcar,Dqcar);


% note: y(:,1-4) = x, y(:,5) = d/dt susp stroke (i.e., x3dot)
% Definition of System States:
% x(1) = z1-z0 = L1     tire deflection
% x(2) = z1dot          wheel cm velocity
% x(3) = z2-z1 = L2     suspension stroke (deflection)
% x(4) = z2dot          sprung mass velocity

% Initialize simulation 
x0 = [0 0 0 0]';                        % initial state

tmax = 5;                               % simulation time length
t = 0:dt:tmax; x = v*t;                 % time/space steps to record output

prof = 0.1*ones(1,length(x)); prof(1) = 0;
z0dot = [0 diff(prof)/dt];
u = z0dot;
umf = 3;    % prepare simulation input


% Simulate quarter car model
y = lsim(qcar,u,t,x0);                      

plot(t,y(:,4))