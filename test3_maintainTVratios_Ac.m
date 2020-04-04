%% SCRIPT FILE: Mainaintng TV ratios in patients with discrepancies (Ac)
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration.
%
% param_config can be either an integer or a structure with parameters to
% be used in the model.
%
% Guide:
% PATIENT A: C_L @ 100%
% PATIENT C: C_L @ 60%
%
%% Tidy up
clc; clear all;

% whichModel = 10; % 0 + 10 (US_PHS recommendations)
whichModel = 'modified';
param_config = 13; % 3 (literature SI Units) + 10 (RM=RO=0)
modR_I = 3150*2;
modR_E = 3150*2;

% grid search on different configurations of PIP and R_V1
newPIP = linspace(12, 20, 5);
newR_V1 = [8 16 32 64 128].*3150;
newR_V2 = 0;

%% Grid search

tva = zeros(length(newPIP), length(newR_V1));
tvc = zeros(length(newPIP), length(newR_V1));

for ix=1:length(newPIP)
    for jx=1:length(newR_V1)
        param_struct = getParametersWithPatients('A', 'c', param_config);
        param_struct.R_D1 = modR_I;
        param_struct.R_D2 = modR_I;
        param_struct.R_E1 = modR_E;
        param_struct.R_E2 = modR_E;
        
        param_struct.R_U1 = newR_V1(jx);
        param_struct.R_U2 = newR_V2;
        param_struct.v_M_inhale = newPIP(ix)*98.0665;
        
        [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
        tva(ix,jx) = tidalVolume(t, y(1).Volume);
        tvc(ix,jx) = tidalVolume(t, y(2).Volume);
        
    end
end
%%
clc
disp('Ac');
for jx=1:length(newR_V1)
    for ix=1:length(newPIP)
        fprintf('%3.2f, %3.2f | %3.2f, %3.2f | %3.2f\n', ...
            newR_V1(jx), newPIP(ix), ...
            tva(ix,jx), tvc(ix,jx), (tva(ix,jx)-tvc(ix,jx)));
    end
end