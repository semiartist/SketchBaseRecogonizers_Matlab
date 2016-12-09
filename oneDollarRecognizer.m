function varargout = oneDollarRecognizer(varargin)

% Last Modified by GUIDE v2.5 21-Mar-2016 23:32:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @oneDollarRecognizer_OpeningFcn, ...
    'gui_OutputFcn',  @oneDollarRecognizer_OutputFcn, ...
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


% --- Executes just before oneDollarRecognizer is made visible.
function oneDollarRecognizer_OpeningFcn(hObject, eventdata, handles, varargin)


% Opening Function code as drawer
% Code by Dr. Eshafani
global drawing drawed newGraph pntNum
drawing =0;
drawed = 0;
set(gcf,'WindowButtonDownFcn',@mouseDown)
set(gcf,'WindowButtonMotionFcn',@mouseMove)
set(gcf,'WindowButtonUpFcn',@mouseUp)
xlim([0 1]); ylim([0 1]);
set(gca,'XTick',[],'YTick',[])

newGraph = zeros(1,3);
pntNum = 0;
tic

% %

% Choose default command line output for oneDollarRecognizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = oneDollarRecognizer_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
cla
global newGraph
global pntNum
newGraph = zeros(1,3);
pntNum = 0;
xlim([0 1]); ylim([0 1]);
set(gca,'XTick',[],'YTick',[])

% --- Executes on button press in rcgButton.
function rcgButton_Callback(hObject, eventdata, handles)
global  shapeName newGraph
% set(handles.resultText, 'String' , shapeName)
% save ('newGraph','newGraph');
sampleSize = 64;
load('OR_Sample_Name');
createOrAdd = questdlg('Create New or Add to Existing' , 'Create or Add' ,...
    'Create New' , 'Add to Existing','Create New');
switch createOrAdd
    case 'Create New'
        createOrAdd = 1;
    case 'Add to Existing'
        createOrAdd = 0;
end;

if newGraph==0;
    msgbox('You need to draw first!')
else
    % enter the add or create loop;
    if createOrAdd
        text(0.5, 0.5, 'Create New One')
        newName = inputdlg('What is the name of new group?')
        OR_Create_New_List(newGraph , newName, sampleSize)
        % add to specific group
    else
        text(0.5 , 0.5, 'Add to existing one');
        [add2Index , choosen] = listdlg('PromptString','Select a Sample to Add:',...
            'SelectionMode','single', 'ListString',OR_Sample_Name(1,:));
        if choosen;
            OR_Add_to_List(newGraph ,add2Index, sampleSize);
        end;
        % add to specific group
    end
end






% % % % % % % % % % % % % % % % % % % % % % % % %
% SELF DEFINED FUNCTIONS%

function mouseDown(hObject, eventdata, handles)
global drawing drawed
drawing = 1;
drawed = 0;

function mouseUp(hObject, eventdata, handles)
global drawing drawed newGraph shapeName
drawing = 0;
sampleSize = 64;
if drawed
    load('OR_Sample_Name');

    result = OR_Get_Number(newGraph , sampleSize);
    drawed = 0;
    if result(2)>0;
        shapeName = OR_Sample_Name(1,result(1));
        color = [0 0.5 1];
    else
        shapeName = 'CAN NOT RECOGNISE';
        color = [1 0 0 ];
    end;
    handles.name = text(0.1,0.1,shapeName);
    set(handles.name, 'Color' , color);
    set(handles.name ,'FontSize',  30);
    set(handles.name , 'FontName' , 'Arial');
    set(handles.name, 'FontWeight' , 'bold');
    handles.pct = text (0.1 , 0.05 ,['Possibility: ' , num2str(result(2)),'%']);
        
%     newGraph = zeros(3,1);
    %     set(handles.output, 'horziong' , 'Right')
    %     @setName;
    %     set(handles.resultText , 'String' , shapeName);
end

function mouseMove(hObject, eventdata, handles)
global drawing pntNum newGraph drawed

if drawing
    drawed = 1;
    C = get(gca,'CurrentPoint');
    if C(1,1)<1 && C(1,1)>0 && C(1,2)<1 && C(1,2)>0
        pntNum = pntNum+1;
        newGraph(pntNum,1) = C(1,1);
        newGraph(pntNum,2) = C(1,2);
        newGraph(pntNum,3) = toc;
        xlim([0 1]); ylim([0 1]);
        set(gca,'XTick',[],'YTick',[])
        if pntNum >1;
            plot(newGraph(pntNum-1:pntNum, 1) , newGraph(pntNum-1:pntNum,2) ,'r','LineWidth',2)
            hold on
        end;
        box on
    end
    
end
