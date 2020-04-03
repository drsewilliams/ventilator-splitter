%% SCRIPT FILE: Model validation 
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration. 
% 
% param_config can be either an integer or a structure with parameters to
% be used in the model. 
%
% Guide:
% PATIENT A: C_L @ 100% 
% PATIENT B: C_L @ 50% 
% PATIENT C: C_L @ 40%
% PATIENT D: C_L @ 30%
% 
%% Tidy up
clear all; close all; clc;

%% TWO PATIENTs A
disp('STEP 1. TWO PATIENTs A');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_stepA] = getInitialParameters(param_config);

[sim_stepA, t_stepA, y_stepA] = ...
    runElectricalAnalogueModel(whichModel, param_stepA);

%% TWO PATIENTs B
disp('STEP 2. TWO PATIENTs B');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_stepB] = getParametersWithPatients('B', 'B', param_config);

[sim_stepB, t_stepB, y_stepB] = ...
    runElectricalAnalogueModel(whichModel, param_stepB);

%% TWO PATIENTs C
disp('STEP 3. TWO PATIENTs C');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_stepC] = getInitialParameters(param_config);
param_stepC.C_L1 = 0.4*param_stepC.C_L1;
param_stepC.C_L2 = 0.4*param_stepC.C_L2;

[sim_stepC, t_stepC, y_stepC] = ...
    runElectricalAnalogueModel(whichModel, param_stepC);

%% TWO PATIENTs D
disp('STEP 4. TWO PATIENTs D');

whichModel = 10; % 0 + 10 (US_PHS recommendations)
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

[param_stepD] = getInitialParameters(param_config);
param_stepD.C_L1 = 0.3*param_stepD.C_L1;
param_stepD.C_L2 = 0.3*param_stepD.C_L2;

[sim_stepD, t_stepD, y_stepD] = ...
    runElectricalAnalogueModel(whichModel, param_stepD);

%% Comparative figures: 

figure(1) 
plotScopeData(t_stepA,y_stepA, {'Patient A1', 'Patient A2'});
figure(2) 
plotScopeData(t_stepB,y_stepB, {'Patient B1', 'Patient B2'});
figure(3) 
plotScopeData(t_stepC,y_stepC, {'Patient C1', 'Patient C2'});
figure(4)
plotScopeData(t_stepC,y_stepC, {'Patient D1', 'Patient D2'});

%% Set variable name to pressure
figure(5) % Compare pressure in all models.

varName = 'pressure';
subplot(321)
plotSingleVariable(t_stepA, y_stepA(1), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(1), varName, '-');
plotSingleVariable(t_stepC, y_stepC(1), varName, '--');
plotSingleVariable(t_stepD, y_stepD(1), varName, '-.');

plotSingleVariable(t_stepA, y_stepA(1), 'control', ':k');

hold off;
grid on;

legend({'Pressure A(1)', 'B(1)', 'C(1)', ...
    'D(1)', 'Control'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

subplot(322)
plotSingleVariable(t_stepA, y_stepA(2), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(2), varName, '-');
plotSingleVariable(t_stepC, y_stepC(2), varName, '--');
plotSingleVariable(t_stepD, y_stepD(2), varName, '-.');

plotSingleVariable(t_stepA, y_stepA(2), 'control', ':k');

hold off;
grid on;

legend({'Pressure A(2)', 'B(2)', 'C(2)', ...
    'D(2)', 'Control'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);


varName = 'volume';
subplot(323)
plotSingleVariable(t_stepA, y_stepA(1), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(1), varName, '-');
plotSingleVariable(t_stepC, y_stepC(1), varName, '--');
plotSingleVariable(t_stepD, y_stepD(1), varName, '-.');

hold off;
grid on;

legend({'Volume A(1)', 'B(1)', 'C(1)', ...
    'D(1)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

subplot(324)
plotSingleVariable(t_stepA, y_stepA(2), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(2), varName, '-');
plotSingleVariable(t_stepC, y_stepC(2), varName, '--');
plotSingleVariable(t_stepD, y_stepD(2), varName, '-.');

hold off;
grid on;

legend({'Volume A(2)', 'B(2)', 'C(2)', ...
    'D(2)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

varName = 'flow';
subplot(325)
plotSingleVariable(t_stepA, y_stepA(1), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(1), varName, '-');
plotSingleVariable(t_stepC, y_stepC(1), varName, '--');
plotSingleVariable(t_stepD, y_stepD(1), varName, '-.');

hold off;
grid on;

legend({'Flow A(1)', 'B(1)', 'C(1)', ...
    'D(1)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

subplot(326)
plotSingleVariable(t_stepA, y_stepA(2), varName, '-+');
hold on;
plotSingleVariable(t_stepB, y_stepB(2), varName, '-');
plotSingleVariable(t_stepC, y_stepC(2), varName, '--');
plotSingleVariable(t_stepD, y_stepD(2), varName, '-.');

hold off;
grid on;

legend({'Flow A(2)', 'B(2)', 'C(2)', ...
    'D(2)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);

title(sprintf('Comparison of %s - Different patients', varName), 'FontSize', 20);

