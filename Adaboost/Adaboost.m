function varargout = Adaboost(varargin)
% Last Modified by GUIDE v2.5 26-Apr-2016 21:30:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Adaboost_OpeningFcn, ...
    'gui_OutputFcn',  @Adaboost_OutputFcn, ...
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


% --- Executes just before Adaboost is made visible.
function Adaboost_OpeningFcn(hObject, eventdata, handles, varargin)
global pointMtx drawing drawed pointNum stroke symbolName trainOrNot;

tic;
stroke = 1;
drawing = 0;
trainOrNot = 0;
drawed = 0;
pointNum = 0 ;
pointMtx = zeros(1,2);
load('ada_symbolName');

xlim([0 1]); ylim([0 1]);
set(gca,'XTick',[],'YTick',[]);


set(gcf,'WindowButtonDownFcn',@mouseDown);
set(gcf,'WindowButtonMotionFcn',@mouseMove);
set(gcf,'WindowButtonUpFcn',@mouseUp);
set(handles.trainMode, 'Value' , 0);
set(handles.buttonPanel, 'Visible' , 'off');

% Choose default command line output for Adaboost
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Adaboost wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Adaboost_OutputFcn(hObject, eventdata, handles)


% Get default command line output from handles structure
varargout{1} = handles.output;



% % GUI OBJECT FUNCTION AREA
% --- Executes on button press in blueButton.
function blueButton_Callback(hObject, eventdata, handles)
xlim([0 1]); ylim([0 1]);
set(gca,'XTick',[],'YTick',[]);
global pointMtx
ada_trainingAdaBoost();


% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
xlim([0 1]); ylim([0 1]);
set(gca,'XTick',[],'YTick',[]);
cla;
global stroke drawing drawed pointNum pointMtx
tic;
stroke = 1;
drawing = 0;
drawed = 0;
pointNum = 0 ;
pointMtx = zeros(1,2);

% --- Executes on button press in trainButton1.
function trainButton1_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;


% --- Executes on button press in trainButton2.
function trainButton2_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;



% --- Executes on button press in trainButton3.
function trainButton3_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;



% --- Executes on button press in trainButton4.
function trainButton4_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;



% --- Executes on button press in trainButton5.
function trainButton5_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;


% --- Executes on button press in trainButton6.
function trainButton6_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;


% --- Executes on button press in trainButton7.
function trainButton7_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;


% --- Executes on button press in trainButton8.
function trainButton8_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;


% --- Executes on button press in trainButton9.
function trainButton9_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
currentSymbol = str2num(get(hObject, 'String'));

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell , 1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;

% --- Executes on button press in trainButton0.
function trainButton0_Callback(hObject, eventdata, handles)
global pointMtx

currentFeature = ada_getFeatures(pointMtx);
% currentSymbol = str2num(get(hObject, 'String'));
currentSymbol = 10;

load('ada_trainFeatureMtxCell');
sampleExistance = size(trainFeatureMtxCell ,1);
if sampleExistance >= currentSymbol;
    currentFeatures = trainFeatureMtxCell{currentSymbol,1};
    currentFeatures = [currentFeatures, currentFeature];
else
    currentFeatures = currentFeature;
end

trainFeatureMtxCell{currentSymbol,1} = currentFeatures;

save('ada_trainFeatureMtxCell','trainFeatureMtxCell');
handles.text1 = text(0.1 ,  0.1,num2str(currentSymbol));
set(handles.text1, 'Color' , [0 0 0.8]);
set(handles.text1 ,'FontSize',  80);
set(handles.text1 , 'FontName' , 'Arial');
set(handles.text1, 'FontWeight' , 'bold');
dispText = ['current symbol: '  num2str(currentSymbol)  ', has total ' num2str(size(currentFeatures,2)) ' samples.'];
handles.text2 = text(0.1 , 0.04 , dispText);
clear trainFeatureMtxCell;


% --- Executes on button press in otherButton.
function otherButton_Callback(hObject, eventdata, handles)
% hObject    handle to otherButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in createButton.
function createButton_Callback(hObject, eventdata, handles)
% hObject    handle to createButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in trainMode.
function trainMode_Callback(hObject, eventdata, handles)
global trainOrNot;
disp(get(hObject,'Value'))
if get(hObject,'Value')
    set(handles.buttonPanel, 'Visible' , 'on')
    trainOrNot =1;
else
    set(handles.buttonPanel, 'Visible' , 'off')
    trainOrNot =0;
end;
varargout{1} = handles.output;


% % SELF DEFINE FUNCTION AREA
% --- MOUSE ACTION FUNCTIONS
function mouseUp(hObject, eventdata, handles)
xlim([0 1]); ylim([0 1]);
set(gca,'XTick',[],'YTick',[])
global pointMtx drawing drawed pointNum stroke symbolName trainOrNot;

if drawed;
    pointNum = 0;
    stroke = stroke+1;
%     disp(get(handles.trainMode, 'Value'));
    if trainOrNot ~=1;
        % FIND RESULT PORTION
        fVector = ada_getFeatures(pointMtx);
        result = ada_getResult2(fVector);
        displayString = symbolName(result);
        handles.display = text(0.1,0.1,displayString);
        
        set(handles.display, 'Color' , [0 0.5 0]);
        set(handles.display ,'FontSize',  80);
        set(handles.display , 'FontName' , 'Arial');
        set(handles.display, 'FontWeight' , 'bold');
    end;
end;
if stroke>1 && pointMtx(2,1,stroke-1) ==0;
    stroke = stroke-1;
end;
drawing = 0;
drawed = 0;
% disp('Size of point matrix');
% disp(size(pointMtx))
% pointMtx


function mouseDown(hObject, eventdata, handles)
% trainOrNot = get(handles.trainMode, 'Value');
global drawing stroke
xlim([0 1]); ylim([0 1]);
set(gca,'XTick',[],'YTick',[]);
drawing = 1;
if stroke >1;
    fill([0.08 0.2 0.2 0.08] , [ 0.05 0.05 0.15 0.15] , 'w','LineStyle' , 'none')
end;

function mouseMove(hObject, eventdata, handles)
global drawing pointNum pointMtx drawed stroke

currentPnt = get(gca,'CurrentPoint');
currentPnt = currentPnt(1,1:2);
if drawing && currentPnt(1,1)<1 && currentPnt(1,1)>0 &&currentPnt(1,2)<1 && currentPnt(1,2)>0;
    pointNum = pointNum+1;
    pointMtx(pointNum,1:2, stroke) = currentPnt;
    pointMtx(pointNum,3, stroke) = toc;
    forPlot = ada_removeZero(pointMtx(:,:,stroke));
    plot(forPlot(:,1) , forPlot(:,2) , 'b' , 'LineWidth' , 2);
    drawed = 1;
    xlim([0 1]); ylim([0 1]);
    set(gca,'XTick',[],'YTick',[])
    hold on;
end;

