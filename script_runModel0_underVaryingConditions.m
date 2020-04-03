%% SCRIPT FILE: RUN MODEL_0 IN DIFFERENT CONDITIONS.
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration. 
% 
%% Tidy up
clear all; close all; clc;

%% Run single lung model (MODEL_SINGLE)

clear t y;
close all;

whichModel = -1; % single model
param_config = 12; % 2 (SI Units) + 10 (RM=RO=0)

[sim_single, t, y] = runElectricalAnalogueModel(whichModel, param_config);

figure(1) 
plotScopeData(t, y);

%% Run double model (MODEL_0) 

clear t y;

whichModel = 10; % 0 + 10 
param_config = 12; % 2 (SI Units) + 10 (RM=RO=0)

[sim_twohealthy, t, y] = runElectricalAnalogueModel(whichModel, param_config);

figure(2) 
plotScopeData(t, y);
figure(3) 
plotSingleVariable(t , y(1), 'control');
