%% SCRIPT FILE: INITIAL automated tests.
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration. 
% 
% param_config can be either an integer or a structure with parameters to
% be used in the model. 
% 
%% Tidy up
clear all; close all; clc;

%% Run single lung model (MODEL_SINGLE)
disp('SINGLE LUNG MODEL');
clear t y;
close all;

whichModel = -1; % single model
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_single] = getInitialParameters(param_config); 

[sim_single, t_single, y_single] = runElectricalAnalogueModel(whichModel, param_single);

%% Run double two healthy sets of lungs 
clear t y;
disp('TWO HEALTHY LUNGS');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_healthypair] = getInitialParameters(param_config); 

[sim_healthypair, t_healthypair, y_healthypair] = ...
    runElectricalAnalogueModel(whichModel, param_healthypair);

%% Healthy + 0.7Compliance

clear t y;
disp('HEALTHY¨LUNG + 0.7 COMPLIANCE');
whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_compliance100vs70] = getInitialParameters(param_config); 
param_compliance100vs70.C_L2 = 0.7*param_compliance100vs70.C_L2;

[sim_compliance100vs70, t_compliance100vs70, y_compliance100vs70] = ...
    runElectricalAnalogueModel(whichModel, param_struct);

%% Comparative figures: 

figure(1) 
plotScopeData(t_single,y_single, {'Single lung'});
figure(2) 
plotScopeData(t_healthypair,y_healthypair, {'Healthy1', 'Healthy2'});
figure(3) 
plotScopeData(t_compliance100vs70,y_compliance100vs70, {'Healthy', 'Compliance 70%'});

%% Set variable name to pressure
figure(4) % Compare pressure in all models.
varName = 'pressure';

%% Set variable name to volume
figure(5) 
varName = 'volume';

%% Set variable name to flow
figure(6) 
varName = 'flow';


%% PLot comparison

plotSingleVariable(t_single, y_single, varName, '-+');
hold on;
plotSingleVariable(t_healthypair, y_healthypair(1), varName, '-');
plotSingleVariable(t_compliance100vs70, y_compliance100vs70(1), varName, '--');
plotSingleVariable(t_compliance100vs70, y_compliance100vs70(2), varName, '--');
if strcmpi(varName, 'pressure')
    plotSingleVariable(t_compliance100vs70, y_compliance100vs70(2), 'control', ':k');
end
hold off;
grid on;

legend({'singleLung', 'healthyPair(1)', 'compliance100vs70(healthy)', ...
    'compliance100vs70(70%)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);

title(sprintf('Comparison of %s - multiple cases', varName), 'FontSize', 20);

