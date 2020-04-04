%% SCRIPT FILE: Modifying TV ratios in identical patients (Bb)
% Using the runElectricalAnalogueModel function. The function takes two
% parameters: whichModel, param_config to select the model and select the
% parameters configuration.
%
% param_config can be either an integer or a structure with parameters to
% be used in the model.
%
% Guide:
% PATIENT B: C_L @ 70%
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
newR_V1 = [0 16 64].*3150;
newR_V2 = [0 16 64].*3150;

%% Grid search

tvb1 = zeros(length(newPIP), length(newR_V1), length(newR_V2));
tvb2 = zeros(length(newPIP), length(newR_V1), length(newR_V2));

for ix=1:length(newPIP)
    for jx=1:length(newR_V1)
        for kx=1:length(newR_V2)
        param_struct = getParametersWithPatients('B', 'b', param_config);
        param_struct.R_D1 = modR_I;
        param_struct.R_D2 = modR_I;
        param_struct.R_E1 = modR_E;
        param_struct.R_E2 = modR_E;
        
        param_struct.R_U1 = newR_V1(jx);
        param_struct.R_U2 = newR_V2(kx);
        param_struct.v_M_inhale = newPIP(ix)*98.0665;
        
        [~, t, y] = runElectricalAnalogueModel(whichModel, param_struct);
        tvb1(ix,jx,kx) = tidalVolume(t, y(1).Volume);
        tvb2(ix,jx,kx) = tidalVolume(t, y(2).Volume);
        end
    end
end
%%
clc
disp('Bb');
for jx=1:length(newR_V1)
    for kx=1:length(newR_V2)
    for ix=1:length(newPIP)
        fprintf('%3.2f, %3.2f %3.2f | %3.2f, %3.2f | %3.2f\n', ...
            newR_V1(jx), newR_V2(kx), newPIP(ix), ...
            tvb1(ix,jx,kx), tvb2(ix,jx,kx), ...
            tvb1(ix,jx,kx)-tvb2(ix,jx,kx));
        end
    end
end