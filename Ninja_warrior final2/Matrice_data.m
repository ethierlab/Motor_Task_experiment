 %% Creation matrice vierge
% matrice_data=NaN(100,10,30);% (temps parcours,jours,rats)
 
 
 %% Enregistrement nouvelles donnees dans matrice
 i= % Cellule rats dans Resume_data
 temps=Resume_data{1,i}.t_passage_compil'; 
 jours=4; % Numéro de l'expérience en cours /8
 rats=9; % No du rats A=1 B=2
 matrice_data(1:numel(temps),jours,rats)=temps;
 

 
 %% Filtrer la matrice en fonction du temps de parcours maximum déterminé
 position=find(matrice_data>0.1);
 
 matrice_data_filtered=matrice_data;
 matrice_data_filtered(position)=NaN;
 