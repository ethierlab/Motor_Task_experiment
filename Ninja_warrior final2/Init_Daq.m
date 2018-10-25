function [session_daq] = Init_Daq(dev_name)
%Initialise le DAQ en créant une session
%   Detailed explanation goes here
% Variable Défaut :

%----

session_daq = daq.createSession('ni');
addDigitalChannel(session_daq,dev_name,'Port0/Line0:1','InputOnly');
%addDigitalChannel(session_daq,dev_name,'Port0/Line2:3','OutputOnly'); %dependamment du hardware


end

