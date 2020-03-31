function Pressure = vent_pressure(t,RR,I,E,PIP,PEEP)

%function that returns the Pressure required for a ventilator at agiven
%time

%assume start with expiration
%Defintions (thanks Wikipidia)
%  PEEP: Positive end-expiratory pressure (PEEP) is the pressure in the lungs 
%       (alveolar pressure) above atmospheric pressure (the pressure outside
%       of the body) that exists at the end of expiration
%  PIP: Peak inspiratory pressure (PIP) is the highest level of pressure 
%       applied to the lungs during inhalation 
% RR: Respiratory Rate (RR) Set number of ventilator breaths per minute.
%t is time in seconds 

%I:E ratio is the ratio of the duration of inspiratory and expiratory phases. 
%normal I:E ratio is 1:2 So 33% of the time is spen inhaline and 67% of the
%time exhaling. Other I:E ratios are 1:1 or 1:1.5. 
% I corresponds to the first value in the reported I:E ratio.
% E corresponds to the second value in the reported I:E ratio.

period = 60/RR;% seconds
local_t = mod(t,period); %seconds
Expiration_time = period/(E+I)*E; %seconds
Pressure = (local_t <= Expiration_time).*PEEP + (local_t > Expiration_time).*PIP ; %cmH2O
  
