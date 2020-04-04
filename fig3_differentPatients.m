%% SCRIPT FILE: Tests with discrepancies in patients
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

% whichModel = 10; % 0 + 10 (US_PHS recommendations)
whichModel = 'modified';
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)

%% Patients discrepancies
disp('Discrepancies in patients');

patient1 = {'A', 'B', 'C', 'D'};
patient2 = {'a', 'b', 'c', 'd'};

for ix=1:length(patient1)
    for jx=(ix+1):length(patient2)
        fprintf('Patient 1 [%s], Patient2 [%s]\n', patient1{ix}, patient2{jx});
        param_struct.([patient1{ix} patient2{jx}]) = ...
            getParametersWithPatients(patient1{ix}, patient2{jx}, param_config);
        
        [~, t.([patient1{ix} patient2{jx}]), y.([patient1{ix} patient2{jx}])] = ...
            runElectricalAnalogueModel(whichModel, param_struct.([patient1{ix} patient2{jx}]));
    end
end

%% Comparison plots - All vs all
figure(1)
plotPairwiseComparison(t, y, 'pressure');
figure(2)
plotPairwiseComparison(t, y, 'volume');
figure(3)
plotPairwiseComparison(t, y, 'flow');


