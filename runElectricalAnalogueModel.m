function [simout, y, t] = runElectricalAnalogueModel(whichModel)
% RUN ELECTRICAL ANALOGUE MODEL ON SIMULINK. This function programatically
% can run any from the electrical analogue model
% 
% USAGE: [simout] = runElectricalAnalogueModel(whichModel)
%
% INPUTS:   whichModel = 0  => ssc_vent_splitter_electrical (model_0)[default]
%           whichModel = 1  => ssc_vent_splitter_electrical_parallelbag (model_1)
%           whichModel = 2  => ssc_vent_splitter_electrical_seriesbag (model_2)
% 
if nargin == 0
    whichModel=0; % or 1, or 2 at the moment
end

mdl = 'ssc_vent_splitter_electrical';
switch whichModel
    case 1
        mdl = strcat(mdl, '_parallelbag');
    case 2
        mdl = strcat(mdl, '_seriesbag');
end
fprintf('[runModel] Running model [%s]\n', mdl);

load_system(mdl);

fprintf('[runModel] Model loaded... Running... \n', mdl);

simout = sim(mdl,'SaveOutput','on',...
   'OutputSaveName','yOut',...
   'SaveTime','on',...
   'TimeSaveName','tOut');

fprintf('[runModel] Finished.\n', mdl);

if nargout > 1
    y = simout.ScopeData.signals;
    t = simout.ScopeData.time;
end