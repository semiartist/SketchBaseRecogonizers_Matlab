function NG_ActionMouseUp (hObject, eventdata, handles, numclass)

% 
% THIS FUNCTION TAKE AUTOMATIC FINISH THE GUI PART ACTION AFTER MOUSE UP.
%
%
%
%
%
%
%


classstr = num2str(numclass);
if get(handles.LearningModeCheckBox, 'Value');
    eval('set(handles.Button' ,classstr, ' , ''ForgoundColor'' , [0 1 0]);');
    set(handles.Display , 'String' ,classstr);
end;

% Update handles structure
guidata(hObject, handles);