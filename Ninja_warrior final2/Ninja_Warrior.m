function varargout = Ninja_Warrior(varargin)
% NINJA_WARRIOR MATLAB code for Ninja_Warrior.fig
%      NINJA_WARRIOR, by itself, creates a new NINJA_WARRIOR or raises the existing
%      singleton*.
%
%      H = NINJA_WARRIOR returns the handle to a new NINJA_WARRIOR or the handle to
%      the existing singleton*.
%
%      NINJA_WARRIOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NINJA_WARRIOR.M with the given input arguments.
%
%      NINJA_WARRIOR('Property','Value',...) creates a new NINJA_WARRIOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ninja_Warrior_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ninja_Warrior_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ninja_Warrior

% Last Modified by GUIDE v2.5 23-Oct-2018 11:08:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ninja_Warrior_OpeningFcn, ...
                   'gui_OutputFcn',  @Ninja_Warrior_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Ninja_Warrior is made visible.
function Ninja_Warrior_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ninja_Warrior (see VARARGIN)

% Initialisation
handles.start_session=0;% Démarre une session
handles.reset_parcours=0;%Reset le passage courant
[handles.session_daq] = Init_Daq('Dev1');
handles.Stop.UserData=1;
handles.Reset.UserData=1;
handles.Pellet_dispenserA=Connect_MotoTrak;
handles.Pellet_dispenserB=Connect_MotoTrak;

% Variable resumant les données
handles.t_passage=[];
handles.t_depart=[];
handles.resume_data{1}.n_passage=[];
handles.resume_data{1}.t_passage_compil=[];
handles.resume_data{1}.rat_id=[];
handles.resume_data{1}.t_depart=[];
handles.t_depart_camera=[];


% Choose default command line output for Ninja_Warrior
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ninja_Warrior wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Ninja_Warrior_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear handles.Pellet_dispenserA
clear handles.Pellet_dispenserB

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_pushbutton1.
function start_pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to start_pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


niveau=get(handles.pro_radiobutton1,'Value');

if niveau==1;
[handles]=pro_loop(handles);
else
[handles] = amateur_loop(handles);
end


% Update handles structure
guidata(hObject, handles);
 

% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Reset.UserData=0;
handles.Stop.UserData=0;
set(handles.Save_current_session_pushbutton5,'Visible','On')

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
 handles.Reset.UserData=0;%Reset le passage courant


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in delete_daq_session.
function delete_daq_session_Callback(hObject, eventdata, handles)
% hObject    handle to delete_daq_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.session_daq)

% Update handles structure
guidata(hObject, handles);



function n_passage_edit1_Callback(hObject, eventdata, handles)
% hObject    handle to n_passage_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_passage_edit1 as text
%        str2double(get(hObject,'String')) returns contents of n_passage_edit1 as a double


% --- Executes during object creation, after setting all properties.
function n_passage_edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_passage_edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t_last_edit2_Callback(hObject, eventdata, handles)
% hObject    handle to t_last_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_last_edit2 as text
%        str2double(get(hObject,'String')) returns contents of t_last_edit2 as a double


% --- Executes during object creation, after setting all properties.
function t_last_edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_last_edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save_current_session_pushbutton5.
function Save_current_session_pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to Save_current_session_pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Rassemble les variables/données de la session en cour
display(handles.t_passage)
n_passage=str2double(get(handles.n_passage_edit1,'String'));

rat_id=get(handles.rat_id_edit3,'String');
num_session=str2double(get(handles.num_session_edit4,'String'));
set(handles.t_last_edit2,'String','NaN');

handles.resume_data{num_session}.n_passage=n_passage;
handles.resume_data{num_session}.t_passage_compil=handles.t_passage;
handles.resume_data{num_session}.rat_id=rat_id;
handles.resume_data{num_session}.t_depart=handles.t_depart ;

assignin('base','Resume_data',handles.resume_data);

% Reset les variable d'affichage :
set(handles.n_passage_edit1,'String',0);
set(handles.rat_id_edit3,'String','Inconnu');
set(handles.num_session_edit4,'String',num_session+1);
set(handles.t_last_edit2,'String','time(s)');

% Reinitialise les variables
handles.t_passage=[];
handles.t_depart=[];
set(handles.Save_current_session_pushbutton5,'Visible','Off') % évite de sauvegarder plus d'une fois la même session


% Update handles structure
guidata(hObject, handles);



function rat_id_edit3_Callback(hObject, eventdata, handles)
% hObject    handle to rat_id_edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rat_id_edit3 as text
%        str2double(get(hObject,'String')) returns contents of rat_id_edit3 as a double


% --- Executes during object creation, after setting all properties.
function rat_id_edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rat_id_edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_session_edit4_Callback(hObject, eventdata, handles)
% hObject    handle to num_session_edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_session_edit4 as text
%        str2double(get(hObject,'String')) returns contents of num_session_edit4 as a double


% --- Executes during object creation, after setting all properties.
function num_session_edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_session_edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Son_pushbutton6.
function Son_pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to Son_pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
[ son] = PelletSound(handles.session_daq);


% Update handles structure
guidata(hObject, handles);



function delai_edit5_Callback(hObject, eventdata, handles)
% hObject    handle to delai_edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delai_edit5 as text
%        str2double(get(hObject,'String')) returns contents of delai_edit5 as a double


% --- Executes during object creation, after setting all properties.
function delai_edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delai_edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timer_edit6_Callback(hObject, eventdata, handles)
% hObject    handle to timer_edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timer_edit6 as text
%        str2double(get(hObject,'String')) returns contents of timer_edit6 as a double


% --- Executes during object creation, after setting all properties.
function timer_edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timer_edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
