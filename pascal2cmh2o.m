function [vecout, cellout] = pascal2cmh2o(vecin)
% CONVERT PASCAL TO cmH2O. Optional cellarray of values for plotting.
% 
const = 0.0101972;
vecout = vecin.*const;
cellout = cell(length(vecin), 1);

for ix=1:length(vecin)
    str = sprintf('%2.1f', vecout(ix));
    cellout{ix} = str;
end
