function [] = Recompense_Beep(session_daq,pos_courante,handles)
%D�livre output 5V (Pellet)
%  � d�finir 1 ou 2 correspondent � quelle pin
% la var sortie AouB indique la position de laquelle le rat partait
% 1 2 c�t� 2 ; 3 4 c�t� 1

if pos_courante==1
%     outputSingleScan(session_daq,[1 1]); % les deux outputs sont on
%     pause(2)
%     outputSingleScan(session_daq,[0 0]);
    handles.Pellet_dispenserA.trigger_feeder(1);
    handles.Pellet_dispenserA.sound_1000(1)
%elseif pos_courante==2
else
%     outputSingleScan(session_daq,[1 1]); % les deux outputs sont on
%     pause(0.3)
%     outputSingleScan(session_daq,[0 0]);
   handles.Pellet_dispenserB.trigger_feeder(1);
    handles.Pellet_dispenserB.sound_1000(1)
end


