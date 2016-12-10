function LineFnl = SS_AddNewLine(LineFnl,tbpLineFnl, linenumber);
% THIS FUNCTION IS TO ADD NEW LINE TO THE LINEFNL MATRIX, UNDER LineSplit
% Function
%
%
%
%
%

% totalcurvenum = LineFnl(:,:,linenumber);

tbplinenum = max(find(LineFnl(:,1,linenumber)~=0));
currentlinenum = find(LineFnl(:,1,linenumber) == tbpLineFnl(1,1));
tbadd = size(tbpLineFnl,1);

if LineFnl(currentlinenum,2,linenumber) ~= tbpLineFnl(end,2);
    error('SPLITTING CURVE START AND END MISS MATCH');
end;

% Move Part;
for cn = tbplinenum:-1:currentlinenum;
    move2num = cn + tbadd -1;
    LineFnl(move2num,:,linenumber) = LineFnl(cn,:,linenumber);
end;

% Add Part;
LineFnl(currentlinenum:(currentlinenum + tbadd -1),1 :7, linenumber ) = tbpLineFnl(:,1:7);


% END OF THE FUCNTION
% FEI CHEN , 2/19/16;
