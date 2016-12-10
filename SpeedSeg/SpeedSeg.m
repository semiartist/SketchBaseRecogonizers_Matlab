function varargout = SpeedSeg(varargin)
% SPEEDSEG MATLAB code for SpeedSeg.fig
%      SPEEDSEG, by itself, creates a new SPEEDSEG or raises the existing
%      singleton*.

% Last Modified by GUIDE v2.5 20-Feb-2016 20:06:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SpeedSeg_OpeningFcn, ...
    'gui_OutputFcn',  @SpeedSeg_OutputFcn, ...
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


% --- Executes just before SpeedSeg is made visible.
function SpeedSeg_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

clc ;

% movegui('northeast')

global drawing mouseclick PntMtx pntnum ;
drawing = 0;
mouseclick = 1;
pntnum = 0;
PntMtx = zeros(1,3,1);

set(gcf,'WindowButtonDownFcn',@MouseDown);
set(gcf,'WindowButtonMotionFcn',@CreateStroke);
set(gcf,'WindowButtonUpFcn',@MouseUp);

tic;
set(handles.TestButton,'Enable','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SpeedSeg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SpeedSeg_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


% --- Executes on button press in ClearButton.
function ClearButton_Callback(hObject, eventdata, handles)
cla ; clc;

global drawing mouseclick PntMtx pntnum ;
drawing = 0;
mouseclick = 1;
pntnum = 0;
PntMtx = zeros(1,3,1);
tic;
set(handles.TestButton,'Enable','off');
set(handles.StrokeBox, 'String' , ' ');
set(handles.BeforeBox, 'String' , ' ');
set(handles.AfterBox , 'String' ,  ' ' );


% --- Executes on button press in ActionButton.
function ActionButton_Callback(hObject, eventdata, handles)
global PntMtx LineFnl Arcs Lines actclicked 

% get segment pnts;
[LineFnl , MarkMtx , FnlMtx] = SS_SegmentFn(PntMtx);
% LineFnl to merge if necessary
[Lines, Arcs] = SS_LineMerge(LineFnl, FnlMtx);

% save('PntMtx1','PntMtx')
% GET INFORMATION AREA
linenum = size(LineFnl,3);
curperln = size(LineFnl,1);
plotmerge = get(handles.PlotSplitChk,'Value');
plotsegment = get(handles.PlotSegPntChk, 'Value');

% PLOT AREA

if plotmerge 
    SS_PlotMergeFn(Lines,Arcs);
else
    SS_PlotFn( FnlMtx, LineFnl);
end;
% plot Segment Pnts
if plotsegment 
    for ln = 1:linenum;
        for cn = 1:curperln;
            if LineFnl(cn,1,ln) ~=0;
                xval = FnlMtx(LineFnl(cn,1,ln) , 1 , ln);
                yval =FnlMtx( LineFnl(cn,1,ln) , 2, ln);
                plot (xval, yval, 'k*' , 'MarkerSize',10);
            end;
        end;
    end;
end
    

set(handles.TestButton,'Enable','on');
actclicked = 1;



% --- Executes on button press in TestButton.
function TestButton_Callback(hObject, eventdata, handles)
global PntMtx Lines Arcs LineFnl

strokenum = size(LineFnl,3);
if size(Arcs,1) ~=1;
    fnlarcnum = size(Arcs,3);
else fnlarcnum = 0;
end;
if size(Lines,1) ~=1;
    fnllinenum = size(Lines,3);
else fnlinenum = 0;
end;
arcnum = size(LineFnl,1);
orilinenum =0; oriarcnum = 0;

for ln = 1:strokenum;
    for an = 1:arcnum;
        if LineFnl(an,3,ln ) ==1;
            orilinenum = orilinenum +1;
        elseif LineFnl(an, 3, ln) ==2;
            oriarcnum == oriarcnum +1;
        end;
    end;
end;
aftermessage1 = 'After Combine/Spliting:';
aftermessage2 = 'Arcs Number is : ';
aftermessage3 = 'Line Number is : ';
aftermessageout = [aftermessage1, 10 , aftermessage2, num2str(fnlarcnum) ...
    , 10 , aftermessage3, num2str(fnllinenum)];

beforemessage1 = 'Before Combine/Splitting:';
beforemessage2 = 'Arcs Number is : ';
beforemessage3 = 'Line Number is : ';
beforemessageout = [beforemessage1, 10 , beforemessage2, num2str(oriarcnum) ...
    , 10 , beforemessage3, num2str(orilinenum)];

message1 = num2str(strokenum);
message2 = 'Strokes you draw this time : ';
messageout = [message2, 10 , message1];

set(handles.StrokeBox, 'String' , messageout);
set(handles.BeforeBox, 'String' , beforemessageout);
set(handles.AfterBox , 'String' , aftermessageout );


% --- Executes on button press in PlotSplitChk.
function PlotSplitChk_Callback(hObject, eventdata, handles)


% --- Executes on button press in PlotSegPntChk.
function PlotSegPntChk_Callback(hObject, eventdata, handles)
% global plotsegment 
% plotsegment = 1;

% Hint: get(hObject,'Value') returns toggle state of PlotSegPntChk


% --- Executes on button press in PlotMergePntChk.
function PlotMergePntChk_Callback(hObject, eventdata, handles)
% hObject    handle to PlotMergePntChk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotMergePntChk

% %Self Defined Functions Position
% %
% %
% %

function MouseDown (hObject, eventdata, handles) ;
global drawing mouseclick PntMtx pntnum drawed
if drawed;
    drawed = 0;
end;

if drawing ;
    pnt = get(gca , 'CurrentPoint');
    if pnt(1,1) <1 && pnt(1,1) >0 && pnt (1,2) >0 && pnt(1,2) <1;
        pntnum = pntnum +1;
        PntMtx(pntnum ,1 ,mouseclick) = pnt(1,1);
        PntMtx(pntnum ,2 ,mouseclick) = pnt(1,2);
        PntMtx(pntnum, 3, mouseclick) = toc;
        plot (PntMtx(:,1,mouseclick) , PntMtx(:,2,mouseclick) ,'.r', 'MarkerFaceColor' , 'r');
        hold on;
        xlim([0 1]) ; ylim([0 1]);
        drawed = 1;
    end
end;

drawing = 1 ;


function MouseUp (hObject, eventdata, handles)
global drawing mouseclick pntnum PntMtx drawed

drawing = 0;
if drawed;
    mouseclick = mouseclick +1;
    drawed = 0;
end;
pntnum = 0;


function CreateStroke (hObject, eventdata, handles);
global drawing mouseclick PntMtx pntnum drawed
drawed =1;
if drawing ;
    pnt = get(gca , 'CurrentPoint');
    if pnt(1,1) <1 && pnt(1,1) >0 && pnt (1,2) >0 && pnt(1,2) <1;
        pntnum = pntnum +1;
        PntMtx(pntnum ,1 ,mouseclick) = pnt(1,1);
        PntMtx(pntnum ,2 ,mouseclick) = pnt(1,2);
        PntMtx(pntnum, 3, mouseclick) = toc;
        plot (PntMtx(:,1,mouseclick) , PntMtx(:,2,mouseclick) ,'.r', 'MarkerFaceColor' , 'r');
        hold on;
        xlim([0 1]) ; ylim([0 1]);
        drawed = 1;
    end
end;
