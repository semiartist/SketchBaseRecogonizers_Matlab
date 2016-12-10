function varargout = ImageBasedRecognizer(varargin)
% IMAGEBASEDRECOGNIZER MATLAB code for ImageBasedRecognizer.fig


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ImageBasedRecognizer_OpeningFcn, ...
    'gui_OutputFcn',  @ImageBasedRecognizer_OutputFcn, ...
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


% --- Executes just before ImageBasedRecognizer is made visible.
function ImageBasedRecognizer_OpeningFcn(hObject, eventdata, handles, varargin)
global drawing drawed pntNum drawNum pointMtx resolution
drawing = 0; pntNum = 0;
drawed = 0; drawNum = 1;
pointMtx = zeros(3,1);
resolution = 48;
% load('IBR_nameCell');
tic;

set(gcf,'WindowButtonDownFcn' , @mouseDown);
set(gcf, 'WindowButtonMotionFcn' , @mouseMove) ;
set(gcf, 'WindowButtonUpFcn' , @mouseUp);
set(handles.majorCanvas, 'XTick' , [] , 'YTick' , []);
set(handles.majorCanvas, 'XLim' ,[0 1] , 'YLim',[0 1]);



% Choose default command line output for ImageBasedRecognizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageBasedRecognizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageBasedRecognizer_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;

% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
global pointMtx pntNum drawed drawNum
pointMtx = zeros(1,1);
pntNum = 0;
drawed = 0;
drawNum = 1;
cla


% --- Executes on button press in otherButton.
function otherButton_Callback(hObject, eventdata, handles)
global pointMtx Graph;
num = inputdlg('what''s this template called');
IBR_add2Template(Graph, num);
% save('IBR_pointMtx2' , 'pointMtx')



% % % % % % % % % % % % % % % % %  % % % % %  % % % % % % % % % % % % % % %
%                        SELF DEFINE FUNCTIONS                            %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

function mouseDown(hObject, eventdata, handles)
global drawing ;
drawing = 1;

fill([0.05 0.23 0.23 0.05] , [ 0 0 0.2 0.2] , 'w')
fill([0.75 1 1 0.75] , [0.75 0.75 1 1] , 'w')

function mouseMove(hObject, eventdata, handles)
global pointMtx drawing pntNum drawed drawNum
if drawing;
    currentP = get(gca, 'CurrentPoint');
    if currentP(1,1)<=1 && currentP(1,1)>=0 && currentP(1,2)<01 && currentP(1,2)>=0;
        pntNum = pntNum +1;
        drawed = 1;
        pointMtx(pntNum,1:2,drawNum) = currentP(1,1:2);
        pointMtx(pntNum,3,drawNum) = toc;
        
        xlim([0 1]); ylim([0 1]); set(gca, 'XTick' , [] , 'YTick' , []);
        %plot(currentP(1,1),currentP(1,2) , 'b','marker','o','MarkerFaceColor' , 'r');
        hold on;
        if pntNum >=2;
            plot( pointMtx(pntNum-1:pntNum,1,drawNum) , pointMtx(pntNum-1:pntNum,2,drawNum) , 'r','LineWidth' , 2);
            hold on;
            set(gca, 'XTick' , [] , 'YTick' , []);
            xlim([0 1]); ylim([0 1]);
            box on;
        end;
    end;
end;


function mouseUp(hObject, eventdata, handles)
global drawing drawed drawNum pointMtx pntNum resolution Graph output rotateInd
drawing = 0; resolution = 48;

load('IBR_nameCell');



if drawed
    drawNum = drawNum+1;
    drawed = 0;
    pntNum = 0;
    [output , Graph ] = IBR_mainFunction(pointMtx , resolution , rotateInd);
    IBR_graphPlotFunction(Graph, resolution);
    st = cell2mat(nameCell{output});
    handles.displ = text(0.1,0.1,st);
    set(handles.displ, 'Color' , [0 0.5 0]);
    set(handles.displ ,'FontSize',  80);
    set(handles.displ , 'FontName' , 'Arial');
    set(handles.displ, 'FontWeight' , 'bold');
end;

% --- Executes on button press in rotationBox.
function rotationBox_Callback(hObject, eventdata, handles)
% hObject    handle to rotationBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rotationBox


% --- Executes when selected object is changed in rotatePanel.
function rotatePanel_SelectionChangedFcn(hObject, eventdata, handles)
global rotateInd;
YesOrNo = get(handles.rotatePanel, 'SelectedObject')
yesOrno = length(get(YesOrNo, 'String'))
if yesOrno == 3
    rotateInd =1;
elseif yesOrno ==2
    rotateInd = 0;
end;


% --- Executes during object creation, after setting all properties.
function rotatePanel_CreateFcn(hObject, eventdata, handles)
global rotateInd;
rotateInd =1;
