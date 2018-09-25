function [  handles] = pro_loop(handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    set(handles.Save_current_session_pushbutton5,'Visible','Off')% Cache le bouton save tant que le stop n'a pas été appuyé
pos_courante = 1;% Pos Départ = 1
Recompense_Beep(handles.session_daq,pos_courante,handles);% Sonne et distribue nourriture
tic;
n_passage=0;
handles.t_passage=[];
handles.t_depart_camera=str2double(get(handles.delai_edit5,'String'));

% Attend la première détection
pos_cible=1;
handles.Stop.UserData=1;%variable qui gère la session
handles.Reset.UserData=1;% variable qui reset le parcours courant

while handles.Stop.UserData==1 && n_passage < 20 ;
    drawnow()
  display('en attente')
    Val_passage=inputSingleScan(handles.session_daq);%
    det_1ou2=find(Val_passage(1:2)>0);%Détecte le rat
    
          
        if det_1ou2 ~= pos_cible; % il commence le parcours
            handles.Reset.UserData=1;% variable qui reset le parcours courant
            display('debut parcours')
            t_deb=toc;
            
            while handles.Reset.UserData==1;
                Val_passage=inputSingleScan(handles.session_daq);%
                det_fin_parcours=find(Val_passage(pos_cible)>0);
                temps_essais=toc-t_deb;
                if  temps_essais>30;
                    break
                end
                if numel(det_fin_parcours)>0
                   t_fin=toc;
                   n_passage=n_passage+1;
                   set(handles.n_passage_edit1,'String',num2str(n_passage));
                   handles.t_passage(n_passage)=t_fin-t_deb;
                   handles.t_depart(n_passage)=t_deb+handles.t_depart_camera;

                   set(handles.t_last_edit2,'String',num2str(handles.t_passage(end)));
                   pos_cible=mod(n_passage,2)+1;
                   display(n_passage)
                   display(handles.t_passage)
                   pause(5);
                   
                   Recompense_Beep(handles.session_daq,pos_cible,handles)
                   
                   break
                end
                drawnow()
            end
            
           
        end
      
        drawnow()
end

end

