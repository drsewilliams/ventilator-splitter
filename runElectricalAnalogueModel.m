function [simout, t, y] = runElectricalAnalogueModel(whichModel, param_config)
% RUN ELECTRICAL ANALOGUE MODEL ON SIMULINK. This function programatically
% can run any from the electrical analogue model
%
% USAGE: [simout] = runElectricalAnalogueModel(whichModel, param_config)
%
% INPUTS:   whichModel = -1 => ssc_vent_splitter_electrical_single (model_single)
%           whichModel = 0  => ssc_vent_splitter_electrical (model_0)[default]
%           whichModel = 1  => ssc_vent_splitter_electrical_parallelbag (model_1)
%           whichModel = 2  => ssc_vent_splitter_electrical_seriesbag (model_2)
%           whichModel = 3  => ssc_vent_splitter_electrical_seriesbagpipe (model_3)
%
%           param_config = -1 (default) does not change anything
%           param_config = 1 Original parameter configuration.
%           param_config = 2 Original parameter configuration (SI units)
%


if nargin == 0
    whichModel=0; % or 1, or 2 at the moment
elseif nargin < 2
    param_config = -1;
end

mdl = 'ssc_vent_splitter_electrical';
switch whichModel
    case {1, 11}
        mdl = strcat(mdl, '_parallelbag');
    case {2, 12}
        mdl = strcat(mdl, '_seriesbag');
    case {3, 13}
        mdl = strcat(mdl, '_seriesbagpipe');
    case -1
        mdl = strcat(mdl, '_single');
end

if whichModel >= 10
    mdl = strcat(mdl, '_us_phs');
end

fprintf('[runModel] Running model [%s]\n', mdl);

mdl_handle = load_system(mdl);
mdlWks = get_param(mdl_handle,'ModelWorkspace');
[param_struct] = getInitialParameters(param_config);
if ~isempty(param_struct)
    % a specific parameter configuration was asked for.
    fprintf('[runModel] Changing simulation parameters to: %s\n', ...
        getConfigurationName(param_config));
    
    param_names = fieldnames(param_struct);
    for ix=1:length(param_names)
        assignin(mdlWks, param_names{ix}, param_struct.(param_names{ix}));
    end
end

fprintf('[runModel] Model loaded [%s] Running... \n', mdl);

simout = sim(mdl,'SaveOutput','on',...
    'OutputSaveName','yOut',...
    'SaveTime','on',...
    'TimeSaveName','tOut');

fprintf('[runModel] Finished.\n');

if nargout > 1
    y(1).Control = simout.ScopeData.signals(1).values;
    y(1).Pressure = simout.ScopeData.signals(2).values;
    y(1).Current = simout.ScopeData.signals(3).values;
    y(1).Charge = simout.ScopeData.signals(4).values;
    if whichModel > -1
        y(2).Control = simout.ScopeData.signals(1).values;
        y(2).Pressure = simout.ScopeData.signals(5).values;
        y(2).Current = simout.ScopeData.signals(6).values;
        y(2).Charge = simout.ScopeData.signals(7).values;
    end
    t = simout.ScopeData.time;
    fprintf('[runModel] Optional output saved to variables.\n');
end