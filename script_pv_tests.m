%% SCRIPT FILE: PV tests for aiding TV
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration. 
% 
% param_config can be either an integer or a structure with parameters to
% be used in the model. 
% 
%% Tidy up
clear all; close all; clc;

%% STEP 1
disp('STEP 1. LOWER PIP - TWO IDENTICAL LUNGS');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_step1] = getInitialParameters(param_config);
param_step1.v_M_inhale = 1372.931; % == 14cmH2O

[sim_step1, t_step1, y_step1] = ...
    runElectricalAnalogueModel(whichModel, param_step1);

%% STEP 2
disp('STEP 2. LUNG2 at 70% COMPLIANCE');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

param_step2 = param_step1; % same as previous step
param_step2.C_L2 = 0.7*param_step1.C_L2; 

[sim_step2, t_step2, y_step2] = ...
    runElectricalAnalogueModel(whichModel, param_step2);

%% STEP 3
disp('STEP 3. RAISE R_u1 DRAMATICALLY');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

param_step3 = param_step2; % same as previous step
param_step3.R_U1 = 980000; % same as the R_ETT 

[sim_step3, t_step3, y_step3] = ...
    runElectricalAnalogueModel(whichModel, param_step3);

%% STEP 4
disp('STEP 4. RAISE PIP BACK TO 18cmH20');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

param_step4 = param_step3; % same as previous step
param_step4.v_M_inhale = 1765.197; % == 18 cmH2O

[sim_step3, t_step4, y_step4] = ...
    runElectricalAnalogueModel(whichModel, param_step4);

%% Comparative figures: 

figure(1) 
plotScopeData(t_step1,y_step1, {'Healthy1(pip=14)', 'Healthy2(pip=14)'});
figure(2) 
plotScopeData(t_step2,y_step2, {'Healthy(pip=14)', 'Compliance 70%(pip=14)'});
figure(3) 
plotScopeData(t_step3,y_step3, {'Healthy(pip=14, Ru1 high)', 'Compliance 70%(pip=14)'});
figure(4)
plotScopeData(t_step4,y_step4, {'Healthy(pip=18, Ru1 high)', 'Compliance 70%(pip=18)'});

% %% Set variable name to pressure
% figure(4) % Compare pressure in all models.
% varName = 'pressure';
% 
% %% Set variable name to volume
% figure(5) 
% varName = 'volume';
% 
% %% Set variable name to flow
% figure(6) 
% varName = 'flow';
% 
% 
% %% PLot comparison
% 
% plotSingleVariable(t_single, y_single, varName, '-+');
% hold on;
% plotSingleVariable(t_step2, y_step1(1), varName, '-');
% plotSingleVariable(t_compliance100vs70, y_compliance100vs70(1), varName, '--');
% plotSingleVariable(t_compliance100vs70, y_compliance100vs70(2), varName, '--');
% if strcmpi(varName, 'pressure')
%     plotSingleVariable(t_compliance100vs70, y_compliance100vs70(2), 'control', ':k');
% end
% hold off;
% grid on;
% 
% legend({'singleLung', 'healthyPair(1)', 'compliance100vs70(healthy)', ...
%     'compliance100vs70(70%)'}, 'Location', 'southoutside', ...
%     'Orientation', 'horizontal', 'FontSize', 16);
% 
% title(sprintf('Comparison of %s - multiple cases', varName), 'FontSize', 20);
% 
