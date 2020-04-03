function plotSingleVariable(t,y,varName, linestylevar)
% PLOT SINGLE VARIABLE. varName is a string with the variable to be plotted.
% 

if nargin < 4 
    linestylevar = '-';
end

fnames = fieldnames(y);
if sum(contains(fnames, varName, 'IgnoreCase', true)) > 0
    whichField = contains(fnames, varName, 'IgnoreCase', true);
    plot(t, y.(fnames{whichField}), linestylevar, 'LineWidth', 2);
else
    disp('Structure variable name not found.');
end
    


