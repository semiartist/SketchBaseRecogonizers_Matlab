function NG_MouseUp(hObject, eventdata, handles)
% When mouse stop move, to calculate the troke's features;
global drawing PntFtr PntMtx drawed pntnum pntnum2 autoclear showdetail learning numclass
drawing = 0;

if drawed
    % CALCULATE THE VALUE OF THE NEW POINTS;
    PntFtr = NG_GetFeature(PntMtx);
    [numclass , rejection] = NG_GetClass ( PntFtr);
    
    % DO THE OUTPUT WITH THE EXPECTED VALUE;
    handles.output = text(0.8,0.2,num2str(numclass));
    set(handles.output, 'Color' , [0 0.5 1 ]);
    set(handles.output ,'FontSize',  150);
    set(handles.output , 'FontName' , 'Arial');
    set(handles.output, 'FontWeight' , 'bold');
    if learning;
        set(handles.output, 'Color' , [ 0.5 0.5 0.5 ]);
    end;
    
    if any(rejection(:,2) == numclass)
        set(handles.output, 'Color' , [0 0.5 1 ]);
    end;
    
    if showdetail
        rejected = rejection(:,1)';
        message = ['The rejected numbers are: ' , int2str(rejected)];
        handles.detail = text( 0.95 , 0.05 , message);
        set(handles.detail , 'HorizontalAlignment' , 'right');
        set(handles.detail, 'Color' , [1 0 0 ]);
        
    end;
    
end;


% % is to auto clear the board;
if autoclear;
    pause(2);
    cla
    PntMtx = zeros(1,3);
    pntnum = 0;
    clear PntFtr;
    tic
end;



drawed = 0;
clear PntMtx;
pntnum = 0;
pntnum2 = 0;

% % END of Function
% FEI CHEN 2/27/16