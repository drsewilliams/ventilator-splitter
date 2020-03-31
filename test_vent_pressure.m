%script to call and test function vent_presssure

close all
clear all 

%output flag
OUTPUT = 1;

%define time
Tend = 20; %seconds
Tstart =0; %seconds
Samples = 100;
t = linspace(Tstart, Tend,Samples); %seconds

%define input parameters
RR = 15; %Breaths per minute;
I = 1; %I:E ratio values
E = 2; %I:E ratio values
PIP = 20; %cmH20
PEEP = 5; %cmH20

%calculate pressure
Pressure = vent_pressure(t,RR,I,E,PIP,PEEP);

%plot outcome

if(OUTPUT)
   plot(t,Pressure)
   xlabel('Time (s)')
   ylabel('Pressure (cmH20)');
end