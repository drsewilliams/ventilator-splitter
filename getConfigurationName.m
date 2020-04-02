function [strconfig] = getConfigurationName(param_config)
% GET MODEL PARAMETERS CONFIGURATION NAME. Simple string describing the
% configuration chosen. This file should be kept in parallel to
% getInitialParameters.m
%
%
if nargin < 1
    param_config = -1;
end
switch param_config
    case -1 % do not change parameters at all
        strconfig = 'Unchanged from model';
    case 1 % original configuration
        % Set the parameters...
        strconfig = 'Original configuration';
        
    case 2 % Original SI Units
        % Set the parameters...
        strconfig = 'Original configuration (SI Units)';
    %case 1000 % load parameters from file?
    otherwise
        strconfig = 'New configuration';
end
