function plotScopeData(t,y,lungtitles)
% PLOTS THE SCOPE DATA.
%

N = length(y);
if nargin < 3
    lungtitles = [];
end

index = 1;
for ix=1:N
    subplot(2,N,index)
    plot(t, y(ix).Control, ':k', t, y(ix).Pressure, '-r', 'LineWidth', 2);
    legend({'Control', 'Pressure'}, 'Location', 'southoutside', ...
        'Orientation', 'horizontal', 'FontSize', 16);
    grid on;
    if ~isempty(lungtitles)
        title([lungtitles{ix} 32 '- Pressure'], 'FontSize', 20);
    end
    
    subplot(2,N,index+N)
    plot(t, y(ix).Current, '-b', t, y(ix).Charge, '--m', 'LineWidth', 2);
    legend({'Current', 'Charge'}, 'Location', 'southoutside', ...
        'Orientation', 'horizontal', 'FontSize', 16);
    grid on;
    if ~isempty(lungtitles)
        title([lungtitles{ix} 32 '- Flow and volume'], 'FontSize', 20);
    end
    
    index = index+1;
end