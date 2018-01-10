% Simulate and animate quarter-car suspension model. Model used originally
% for an optimization demonstration in ME 149, Engineering System Design
% Optimization, a graduate course taught at Tufts University in the
% Mechanical Engineering Department. A corresponding video is available at:
% 
% http://www.youtube.com/watch?v=_jKceIHn6tc
%
% The model is based on the electric vehicle design case study found in the
% dissertation by James T. Allison:
%
% http://deepblue.lib.umich.edu/handle/2027.42/58449
%
% Author: James T. Allison, Assistant Professor, University of Illinois at
% Urbana-Champaign
% Date: 3/4/12


% Clear workspace and set plotting flags
clear;
ploton1 = 1;            % animate qcar response
ploton2 = 2;            % plot response

% Initialize vehicle parameters:
C = 2;               % specify suspension design case
switch C
    case 1           % tuned for comfort
        k = 500.4;
        c = 24.67;
    case 2           % tuned for handling
        k = 505.33;
        c = 1897.9;
    case 3           % not optimal
        k = 1000;
        c = 1000;
end

ms = 325;               % 1/4 sprung mass (kg)
mus = 65;               % 1/4 unsprung mass (kg)
kus = 232.5e3;          % tire stiffness (N/m)
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
load IRI_737b                           % road profile data
dx = road_x(2) - road_x(1);             % spacial step for input data
dt2 = dx/v;                             % time step for input data
z0dot = [0 diff(road_z)/dt];            % road profile velocity     
tmax = 5;                               % simulation time length
t = 0:dt:tmax; x = v*t;                 % time/space steps to record output
u = interp1(road_x,z0dot,x);umf = 3;    % prepare simulation input


u=0.1*ones(size(t));


% Simulate quarter car model
y = lsim(qcar,u,t,x0);                      
deltamaxf = max(abs(y(:,1)));           % max x3 amplitude  
z2dotdot = [0 diff(y(:,4))'/dt2];       % sprung mass acceleration

% animate response
if ploton1
    z0 = interp1(road_x,road_z,x)'*umf; % road elevation
    z1 = z0 + y(:,1);                   % wheel cm position
    z2 = z1 + y(:,3);                   % sprung mass position
    zmf = 3;    % exaggerate response for better visualization
    for i=1:length(t)
        plotsusp([z0(i), z1(i)*zmf, z2(i)*zmf, t(i)],road_x,road_z,x(i),umf);
        refresh
    end
end

% plot response
if ploton2
    figure(2);clf                       
    plot(t,y(:,3),'r-',t,y(:,5),'k-'); hold on         
    plot(t,u*umf);
    plot(t,z2dotdot,'g-')
    legend('stroke','stroke velocity', ...
        'road input velocity','sprung mass accel')    
end


