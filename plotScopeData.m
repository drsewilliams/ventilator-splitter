function plotScopeData(t,y)
% PLOTS THE SCOPE DATA.
%

N = length(y);
index = 1;
for ix=1:N
    subplot(2,N,index)
    plot(t, y(ix).Control, ':k', t, y(ix).Pressure, '-r', 'LineWidth', 2);
    legend({'Control', 'Pressure'}, 'Location', 'southoutside', ...
        'Orientation', 'horizontal');
    
    subplot(2,N,index+N)
    plot(t, y(ix).Current, '-b', t, y(ix).Charge, '--m', 'LineWidth', 2);
    legend({'Current', 'Charge'}, 'Location', 'southoutside', ...
        'Orientation', 'horizontal');
    
    index = index+1;
end