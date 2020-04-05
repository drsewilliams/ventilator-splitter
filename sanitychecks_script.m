%% SCRIPT FILE: Sanity checks
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration.
%
% param_config can be either an integer or a structure with parameters to
% be used in the model.
%
% Guide:
% PATIENT A: C_L @ 100%
%
%% Tidy up
clc;

newPIP = 15*98.0665; % PIP @ 15 cmH2O
%% 1.) Change lung compliance to 60ml/cmH2O as per Campbell and Brown 
% and report back on TV achieved

whichModel = 'standard';
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)
%modC_L = 6.1183e-07; % 0.064
modC_L = 5.50646758e-07;

[param_step1] = getInitialParameters(param_config);

% On-the-fly modifications to the parameters
param_step1.v_M_inhale = 15*98.0665; % PIP @ 15 cmH2O
param_step1.C_L1 = modC_L;
param_step1.C_L2 = modC_L;

[~, t_1, y_1] = runElectricalAnalogueModel(whichModel, param_step1);

results.step1 = tidalVolume(t_1, y_1(1).Volume);

%% 2.) Replace lung model with two capacitors.
whichModel = 'twolungs'; % fork of 'standard with two lungs (hardcoded values)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_step2] = getInitialParameters(param_config);

% On-the-fly modifications to the parameters
param_step2.v_M_inhale = 15*98.0665; % PIP @ 15 cmH2O

[~, t_2, y_2] = runElectricalAnalogueModel(whichModel, param_step2);

results.step2 = tidalVolume(t_2, y_2(1).Volume);

%% 3.) Case 1.) but with all the tubes 1.8m  REs and RIs by 1.8.
% Check TVs and see if reduced. Should come down very very slightly.
whichModel = 'standard';
modR_I = 3150*1.8;
modR_E = 3150*1.8;

[param_step3] = param_step1;
% On-the-fly modifications to the parameters
param_step3.v_M_inhale = 15*98.0665; % PIP @ 15 cmH2O
param_step3.R_D1 = modR_I;
param_step3.R_D2 = modR_I;
param_step3.R_E1 = modR_E;
param_step3.R_E2 = modR_E;

[~, t_3, y_3] = runElectricalAnalogueModel(whichModel, param_step3);

results.step3 = tidalVolume(t_3, y_3(1).Volume);

%% 4.) Case 3.) but adding capacitors in parallel to each RE, RI
%
whichModel = 'tubingcompliance'; % fork of 'standard' with tubing compliances (hardcoded values)
param_step4 = param_step3;
% On-the-fly modifications to the parameters
param_step4.v_M_inhale = 15*98.0665; % PIP @ 15 cmH2O

[~, t_4, y_4] = runElectricalAnalogueModel(whichModel, param_step4);

results.step4 = tidalVolume(t_4, y_4(1).Volume);

