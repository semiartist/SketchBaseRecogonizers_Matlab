function LineFnl = SS_LineSplit (LineFnl, FnlMtx)

%
% THIS FUNCTION IS TO MERGE THE UNNECESSARY SPLITTED CURVES, OR SPLITTING
% THE MISS SPLITED CURVES;
%
%
%
%


% TEST AREA
% clear ; close ; clc;
% load('LineSplit')
% load('LineSplitLineFnl')

% Get Basic Information;
linenum = size(FnlMtx ,3);


% if need to break;
for ln = 1:linenum;
    tbprocess = LineFnl(:,:,ln);
    tbprocess = SS_RemoveZero(tbprocess);
    fitnum = size(tbprocess,1);
    
    for fn = 1:fitnum;
        linespeedthreshold = 0.6;
        % for line fit, do not need to split;
        if tbprocess(fn,3) == 2
            actstart = tbprocess(fn,1);
            actend = tbprocess(fn,2);
            % get the degree it swept;
            tbpSplit = FnlMtx(tbprocess(fn,1):tbprocess(fn,2) , : ,ln );
            if tbprocess(fn,4) > 2;
                tbpLineFnl = SS_AccurateSplit (tbpSplit , tbprocess(fn,:) )
            elseif tbprocess(fn,4) > 0.8 | isnan(tbprocess(fn,4) );
                % RESPLIT THE CURVE WITH HIGHER SPEED THRESHOLD
                tbpMarkMtx = SS_GetSegmentPnt(tbpSplit , linespeedthreshold);
                [tbpLineIni, tbpMarkMtx] = SS_SegmentPostProcess(tbpMarkMtx , tbpSplit);
                tbpLineFnl = SS_LinePostProcess (tbpLineIni, tbpSplit);
            end;
            
            if tbprocess(fn,4) > 0.8 | isnan(tbprocess(fn,4) );

                % merget the number;
                tbpLineFnl(:,1:2) = tbpLineFnl(:,1:2)+actstart-1;
                
                % make the start pnt and the last pnt match;
                tbpLineFnl(1,1) = actstart;
                tbpLineFnl(end,2) = actend;
                
                % try to put the curve back to the ORIGINAL LINEFNL MATRIX
                % is break, how to break;
                % store degree inforamton into LineFnl and tbprocess;
                lineadd = size(tbpLineFnl,1);
                LineFnl = SS_AddNewLine(LineFnl,tbpLineFnl, ln);
                fn = fn + lineadd-1;
                fitnum = fitnum +lineadd - 1;                
            end
        end;       
    end;
end;
% LineFnl(:,8:9,:)




% Judge Each Segment's Fitting Performance;

% If mistake rate bigger than a threshold, then segment;

