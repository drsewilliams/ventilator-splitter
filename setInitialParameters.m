%% Set initial parameters for simscape electrical model
% Run a specific cell in this script file to save a specific set of
% parameters to the given MAT-file. Then, open the MODEL EXPLORER on
% Simulink and load the MODEL WORKSPACE with the MAT file you just created.
%

%% Original parameters  
% First, clear any parameter from this model that might be in the workspace 
clear v_M_exhale v_M_inhale R_M R_U1 R_U2 R_D1 R_D2 R_L1 R_L2 C_L1 ...
    C_L2 R_E1 R_E2 R_O RR I E IE_ratio; 

% Set the parameters...
v_M_exhale = 5;% Pa PEEP = 5cmH20
v_M_inhale = 20; % PIP = 20cmH2O
R_M = 1; % Pa*s/m^3
% current = m^3/s
% charge = m^3
% tube length = 1.5 m?
R_U1 = 1;
R_U2 = 1;
R_D1 = 1;
R_D2 = 1;

R_L1 = 1e2; % want 2.0cmH2O/L/s
R_L2 = 1e2;
C_L1 = 1e-3; % 0.064 L/cmH2O into m^3/Pa
C_L2 = 2e-3;

R_E1 = 1;
R_E2 = 1;
R_O = 1;

RR = 15;
I = 1;
E = 2;
IE_ratio = I/E;

% ... and save them with a useful name
save('Ventilator_Electrical_Parameters');

%% Conversion to SI units
% First, clear any parameter from this model that might be in the workspace 
clear v_M_exhale v_M_inhale R_M R_U1 R_U2 R_D1 R_D2 R_L1 R_L2 C_L1 ...
    C_L2 R_E1 R_E2 R_O RR I E IE_ratio; 
clc; 

% Set the parameters...
v_M_exhale = 490;% Pa PEEP = 5cmH20
v_M_inhale = 1960; % PIP = 20cmH2O
R_M = 1; % Pa*s/m^3
% current = m^3/s
% charge = m^3
% tube length = 1.5 m?
R_U1 = 1;
R_U2 = 1;
R_D1 = 1;
R_D2 = 1;

R_L1 = 196133; % want 2.0cmH2O/L/s
R_L2 = 196133;
C_L1 = 6.5261838e-7; % 0.064 L/cmH2O into m^3/Pa
C_L2 = 6.5261838e-7;

R_E1 = 1;
R_E2 = 1;
R_O = 1;

RR = 15;
I = 1;
E = 2;
IE_ratio = I/E;

% ... and save them with a useful name
save('Ventilator_Electrical_Parameters_SIUnits');
