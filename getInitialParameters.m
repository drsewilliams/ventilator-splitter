function [param_struct] = getInitialParameters(param_config)
% GET MODEL PARAMETERS STRUCTURE. Creates a structure which contains all
% the model parameters. To be changed and run programatically using
% function runElectricalAnalogueModel.
%
%
if nargin < 1
    param_config = -1;
end
switch param_config
    case -1 % do not change parameters at all
        param_struct = [];
    case 1 % original configuration
        % Set the parameters...
        param_struct.v_M_exhale = 5;% Pa PEEP = 5cmH20
        param_struct.v_M_inhale = 20; % PIP = 20cmH2O
        param_struct.R_M = 1; % Pa*s/m^3
        % current = m^3/s
        % charge = m^3
        % tube length = 1.5 m?
        param_struct.R_U1 = 1;
        param_struct.R_U2 = 1;
        param_struct.R_D1 = 1;
        param_struct.R_D2 = 1;
        
        param_struct.R_L1 = 1e2; % want 2.0cmH2O/L/s
        param_struct.R_L2 = 1e2;
        param_struct.C_L1 = 1e-3; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_L2 = 2e-3;
        param_struct.ETT_factor1 = 10;
        param_struct.ETT_factor2 = 10;
        
        % === artificial patients ====
        param_struct.R_aL1 = 1e2; % want 2.0cmH2O/L/s
        param_struct.R_aL2 = 1e2;
        param_struct.C_aL1 = 1e-3; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_aL2 = 2e-3;
        % =======
        
        param_struct.R_E1 = 1;
        param_struct.R_E2 = 1;
        param_struct.R_O = 1;
        
        param_struct.RR = 15;
        param_struct.I = 1;
        param_struct.E = 2;
        
    case 2 % Original SI Units
        % Set the parameters...
        param_struct.v_M_exhale = 490;% Pa PEEP = 5cmH20
        param_struct.v_M_inhale = 1960; % PIP = 20cmH2O
        param_struct.R_M = 4000; % Pa*s/m^3
        % current = m^3/s
        % charge = m^3
        % tube length = 1.5 m?
        param_struct.R_U1 = 4000;
        param_struct.R_U2 = 4000;
        param_struct.R_D1 = 4000;
        param_struct.R_D2 = 4000;
        
        param_struct.R_L1 = 196133; % want 2.0cmH2O/L/s
        param_struct.R_L2 = 196133;
        param_struct.C_L1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_L2 = 6.5261838e-7;
        param_struct.ETT_factor1 = 10;
        param_struct.ETT_factor2 = 10;
        
        % === artificial patients ====
        param_struct.R_aL1 = 196133; % want 2.0cmH2O/L/s
        param_struct.R_aL2 = 196133;
        param_struct.C_aL1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
        param_struct.C_aL2 = 6.5261838e-7;
        % =======
        
        param_struct.R_E1 = 4000;
        param_struct.R_E2 = 4000;
        param_struct.R_O = 4000;
        
        param_struct.RR = 15;
        param_struct.I = 1;
        param_struct.E = 2;
    %case 1000 % load parameters from file?
end

param_struct.IE_ratio = param_struct.I/ param_struct.E;

