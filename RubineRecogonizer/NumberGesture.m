function varargout = NumberGesture(varargin)
% NUMBERGESTURE MATLAB code for NumberGesture.fig
% Last Modified by GUIDE v2.5 01-Mar-2016 21:19:36
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @NumberGesture_OpeningFcn, ...
    'gui_OutputFcn',  @NumberGesture_OutputFcn, ...
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


% --- Executes just before NumberGesture is made visible.
function NumberGesture_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
set(gca,'XTick',[],'YTick',[])
xlim([0 1]); ylim([0 1]);

% % FOR DRAWING PURPOSE % %
global drawing pntnum PntMtx pntnum2 drawed   PntMtx2 autoclear showdetail learning numclass
% numclass = null;
drawing =0;
set(gcf,'WindowButtonDownFcn',@NG_MouseDown)
set(gcf,'WindowButtonMotionFcn',@NG_MouseMove)
set(gcf,'WindowButtonUpFcn',@NG_MouseUp)

PntMtx2 = zeros(1,2);
pntnum = 0;
PntMtx = zeros(1,3);
pntnum2 = 0;
drawed = 0;

autoclear = 0;
showdetail = 0;
learning = 0;
set(handles.AutoEraseCheckBox, 'Value' , 0);

% % % % END OF DRAWING PART

% % FOR TRAINING PURPOSE
global TrainData
% Construction of training data;
% TrainData = zeros(1,2);

% load existing training dta;
load('NG_TrainData');

% % % % END OF TRAINING PURPOSE

% % SET THE NNUMBERPAD TO MUTE
set(handles.Button1 , 'Enable' ,'off');
set(handles.Button2 , 'Enable' ,'off');
set(handles.Button3 , 'Enable' ,'off');
set(handles.Button4 , 'Enable' ,'off');
set(handles.Button5 , 'Enable' ,'off');
set(handles.Button6 , 'Enable' ,'off');
set(handles.Button7 , 'Enable' ,'off');
set(handles.Button8 , 'Enable' ,'off');
set(handles.Button9 , 'Enable' ,'off');
set(handles.Button0 , 'Enable' ,'off');
set(handles.RecalButton , 'Enable' ,'off');


handles.output = hObject;
tic
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NumberGesture wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NumberGesture_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Button1.
function Button1_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 1;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');


% --- Executes on button press in Button2.
function Button2_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 2;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');


% --- Executes on button press in Button5.
function Button5_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 5;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');


% --- Executes on button press in Button3.
function Button3_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 3;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');

% --- Executes on button press in Button0.
function Button0_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 10;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');


% --- Executes on button press in Button4.
function Button4_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 4;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');


% --- Executes on button press in Button7.
function Button7_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 7;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');

% --- Executes on button press in Button8.
function Button8_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 8;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');


% --- Executes on button press in Button6.
function Button6_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 6;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');


% --- Executes on button press in Button9.
function Button9_Callback(hObject, eventdata, handles)
global PntFtr TrainData
truevalue = 9;
TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue);
save('NG_TrainData' , 'TrainData');

% --- Executes on button press in AutoEraseCheckBox.
function AutoEraseCheckBox_Callback(hObject, eventdata, handles)
global autoclear
if get(hObject, 'Value');
    autoclear = 1;
else 
    autoclear = 0;
end;


% --- Executes on button press in LearningModeCheckBox.
function LearningModeCheckBox_Callback(hObject, eventdata, handles)
global learning autoclear
if get(hObject, 'Value')
    set(handles.Button1 , 'Enable' ,'on');
    set(handles.Button2 , 'Enable' ,'on');
    set(handles.Button3 , 'Enable' ,'on');
    set(handles.Button4 , 'Enable' ,'on');
    set(handles.Button5 , 'Enable' ,'on');
    set(handles.Button6 , 'Enable' ,'on');
    set(handles.Button7 , 'Enable' ,'on');
    set(handles.Button8 , 'Enable' ,'on');
    set(handles.Button9 , 'Enable' ,'on');
    set(handles.Button0 , 'Enable' ,'on');
    set(handles.RecalButton , 'Enable' ,'on');
    set(handles.AutoEraseCheckBox, 'Enable' , 'off');
    set(handles.AutoEraseCheckBox, 'Value' , 0);
    learning = 1;
        autoclear=0;
else
    set(handles.Button1 , 'Enable' ,'off');
    set(handles.Button2 , 'Enable' ,'off');
    set(handles.Button3 , 'Enable' ,'off');
    set(handles.Button4 , 'Enable' ,'off');
    set(handles.Button5 , 'Enable' ,'off');
    set(handles.Button6 , 'Enable' ,'off');
    set(handles.Button7 , 'Enable' ,'off');
    set(handles.Button8 , 'Enable' ,'off');
    set(handles.Button9 , 'Enable' ,'off');
    set(handles.Button0 , 'Enable' ,'off');
    set(handles.RecalButton , 'Enable' ,'off');
    set(handles.AutoEraseCheckBox, 'Enable' , 'on');
    learning = 0;

end;


% --- Executes on button press in ClearButton.
function ClearButton_Callback(hObject, eventdata, handles)
cla ; %clc;
global PntMtx pntnum  pntnum2
% PntMtx2 = zeros(1,3);
PntMtx = zeros(1,3);
pntnum = 0;
% pntnum2 = 0;
% load('TrainData')
tic

% --- Executes on button press in SaveButton.
function SaveButton_Callback(hObject, eventdata, handles)
global PntFtr TrainData  numclass
if numclass ==0;
    numclass = 10;
end;
TrainData = NG_AddTrainData(TrainData, PntFtr , numclass);
save('NG_TrainData' , 'TrainData');

% --- Executes on button press in RecalButton.
function RecalButton_Callback(hObject, eventdata, handles)
global weightbyclass weightbyfeature
load ('NG_TrainData');
[weightbyclass , weightbyfeature , TrainMeanMtx] = NG_GetCoverianceMtx (TrainData)
save('NG_weightbyfeature' ,'weightbyfeature');
save('NG_weightbyclass' ,'weightbyclass');
save('NG_TrainMeanMtx' , 'TrainMeanMtx');

% % BELOW ARE THE SELF DEFINED FUNCTIONS


% --- Executes on mouse press over axes background.
function Canvas_ButtonDownFcn(hObject, eventdata, handles)

function Canvas_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in DetailCheckBox.
function DetailCheckBox_Callback(hObject, eventdata, handles)
global showdetail
if get(hObject, 'Value');
    showdetail = 1;
else 
    showdetail = 0;
end;
