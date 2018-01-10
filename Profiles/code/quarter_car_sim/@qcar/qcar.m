classdef qcar < handle
%% classdef qcar
% 
% 
% 
% author: John Braley
% create date: 12-Oct-2017 12:27:24
% classy version: 0.1.2

%% object properties
	properties
        ssmodel         % state space model
        profile         % velocity profile over which the model traverses
        time            % time vector for each step of simulation
        x0              % initial conditions of states
	end

%% dependent properties
	properties (Dependent)
	end

%% private properties
	properties (Access = private)
	end

%% constructor
	methods
		function self = qcar()
		end
	end

%% ordinary methods
	methods 
	end % /ordinary

%% dependent methods
	methods 
	end % /dependent

%% static methods
	methods (Static)
	end % /static

%% protected methods
	methods (Access = protected)
	end % /protected

end
