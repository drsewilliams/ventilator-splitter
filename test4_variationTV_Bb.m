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

%% Figures 
I=[2 3 5];
J=[2 3 3];
K=[2 2 1];

cases = {'equal', 'medium', 'different'};

for ix=1:3
    param_struct = getParametersWithPatients('B', 'b', param_config);
        param_struct.R_D1 = modR_I;
        param_struct.R_D2 = modR_I;
        param_struct.R_E1 = modR_E;
        param_struct.R_E2 = modR_E;
        
        param_struct.R_U1 = newR_V1(J(ix));
        param_struct.R_U2 = newR_V2(K(ix));
        param_struct.v_M_inhale = newPIP(I(ix))*98.0665;
        
        switch ix
            case 1
                [~, t.equal, y.equal] = runElectricalAnalogueModel(whichModel, param_struct);
            case 2
                [~, t.medium, y.medium] = runElectricalAnalogueModel(whichModel, param_struct);
            case 3
                [~, t.different, y.different] = runElectricalAnalogueModel(whichModel, param_struct);
        end
end
%%
varName = 'pressure';
figure(41)
subplot(211)
plotSingleVariable(t.equal, y.equal(1), varName, '-+');
hold on;
plotSingleVariable(t.medium, y.medium(1), varName, '-');
plotSingleVariable(t.different, y.different(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'equal', 'medium', 'different', ...
    'D(1)', 'Control'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Bb', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t.equal, y.equal(2), varName, '-+');
hold on;
plotSingleVariable(t.medium, y.medium(2), varName, '-');
plotSingleVariable(t.different, y.different(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);


hold off;
grid on;

legend({'equal', 'medium', 'different', ...
    'D(2)', 'Control'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Bb', varName), 'FontSize', 20);
set(gcf, 'Position', [36         101        1556         879]);

varName = 'volume';
figure(42)
subplot(211)
plotSingleVariable(t.equal, y.equal(1), varName, '-+');
hold on;
plotSingleVariable(t.medium, y.medium(1), varName, '-');
plotSingleVariable(t.different, y.different(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'equal', 'medium', 'different', ...
    'D(1)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Bb', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t.equal, y.equal(2), varName, '-+');
hold on;
plotSingleVariable(t.medium, y.medium(2), varName, '-');
plotSingleVariable(t.different, y.different(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'equal', 'medium', 'different', ...
    'D(2)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Bb', varName), 'FontSize', 20);
set(gcf, 'Position', [36         101        1556         879]);
varName = 'flow';
figure(43)
subplot(211)
plotSingleVariable(t.equal, y.equal(1), varName, '-+');
hold on;
plotSingleVariable(t.medium, y.medium(1), varName, '-');
plotSingleVariable(t.different, y.different(1), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'equal', 'medium', 'different', ...
    'D(1)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Bb', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t.equal, y.equal(2), varName, '-+');
hold on;
plotSingleVariable(t.medium, y.medium(2), varName, '-');
plotSingleVariable(t.different, y.different(2), varName, '--');
[~, newyticks] = siunits2clinical(yticks, varName);
yticklabels(newyticks);

hold off;
grid on;

legend({'equal', 'medium', 'different', ...
    'D(2)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);

title(sprintf('Comparison of %s - Bb', varName), 'FontSize', 20);
set(gcf, 'Position', [36         101        1556         879]);

figure(44) % Modified Volume
varName = 'ModifiedVol';
subplot(211)
plotSingleVariable(t.equal, y.equal(1), varName, '-+');
hold on;
plotSingleVariable(t.medium, y.medium(1), varName, '-');
plotSingleVariable(t.different, y.different(1), varName, '--');

hold off;
grid on;

legend({'equal', 'medium', 'different', ...
    'D(1)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Bb', varName), 'FontSize', 20);

subplot(212)
plotSingleVariable(t.equal, y.equal(2), varName, '-+');
hold on;
plotSingleVariable(t.medium, y.medium(2), varName, '-');
plotSingleVariable(t.different, y.different(2), varName, '--');

set(gcf, 'Position', [36         101        1556         879]);

hold off;
grid on;

legend({'equal', 'medium', 'different', ...
    'D(2)'}, 'Location', 'southoutside', ...
    'Orientation', 'horizontal', 'FontSize', 16);
title(sprintf('Comparison of %s - Bb', varName), 'FontSize', 20);

