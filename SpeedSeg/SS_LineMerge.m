function [NewLines, NewArcs] = SS_LineMerge(LineFnl , FnlMtx)
%
% THIS FUNCTION IS TO FIND THE POSSBILE MERGING POINT OF EACH ARC/LINE,
% THEN OUTPUT THE AFTER MERGING X - Y LOCATION WITH A 3-D MATRIX FORMAT.
% WHICH COULD BE USED DIRECTILY IN PLOTTING;
%
%
%
%
%
%
%

% GET BASIC INFORMATION
linenum = size (FnlMtx,3);

% GET 2 MATRIX, LINES AND ARCS
Lines = zeros(1,4);
Arcs = zeros(1,4);

lineqty = 0;
arcqty =0;
if linenum~=0
    for ln = 1: linenum;
        tbp = LineFnl(:,:,ln);
        tbp = SS_RemoveZero(tbp);
        arcnum = size(tbp,1);
        if isempty(tbp)==0
            for arc = 1:arcnum;
                if tbp(arc,3) == 1; % how many lines;
                    lineqty = lineqty + 1;
                    currentline(:,1:2) = FnlMtx(tbp(arc,1): tbp(arc,2) , 1:2 , ln);
                    currentline(1:end,3) = tbp (arc,5);
                    currentline(1:end,4) = tbp (arc,6);
                    currentline(1:end,5) = ln;
                    currentline(1:end,6) = arc;
                    Lines = SS_Merge(Lines, currentline, 3);
                    linek(lineqty,1:2) = [tbp(arc,5) , lineqty];
                    clear currentline;
                elseif tbp(arc, 3) ==2;
                    arcqty = arcqty +1;
                    currentarc = FnlMtx(tbp(arc,1):tbp(arc,2) , 1:2 , ln);
                    currentarc(:,3) = tbp (arc,5);
                    currentarc(:,4) = tbp (arc,6);
                    currentarc(:,5) = tbp (arc,7);
                    currentarc(:,6) = tbp (arc,8);
                    currentarc(:,7) = tbp (arc,9);
                    currentarc(:,8) = ln;
                    currentarc(:,9) = arc;
                    Arcs = SS_Merge(Arcs, currentarc,3);
                    clear currentarc;
                end;
            end;
        end;
    end;
    
    % Then to define if need to combine liens and arcs matrix;
    tbclinenum = size(Lines,3);
    tbcarcnum = size(Arcs, 3);
    
    % sort the lines with k from low to high;
    if exist('linek')
    linek(1:end,3) = atand(linek(:,1));
    linek = sortrows(linek);
    linek(1,4) = 10;
    linek(2:end,4) = diff(linek(:,3));
    end;

end;

% Consider Combination possibility;
NewLines = 0;
NewArcs = 0;
% mergeqty = 0;
% and do combine if necessary
if tbclinenum >1;
    for ln =2: tbclinenum;
        handle1 = SS_RemoveZero(Lines(:,:,linek(ln-1,2)));
        handle2 = SS_RemoveZero( Lines(:,:,linek(ln,2)));
        
        if ~exist('temp')
            temp = handle1;
        end;
        
        if linek(ln,4) < 7 ;
            % calculat the start and end points distance;
            long1 = norm(handle1(1,1:2) - handle1(end,1:2));
            long2 = norm(handle2(1,1:2) - handle2(end,1:2));
            longmax = max(long1, long2);
            long = long1 + long2;
            
            dis1 = norm(handle1(1,1:2) - handle2(1,1:2));
            dis2 = norm(handle1(end,1:2) - handle2(1,1:2));
            dis3 = norm(handle1(1,1:2) - handle2(end,1:2));
            dis4 = norm(handle1(end,1:2) - handle2(end,1:2));
            dismin = min([dis1, dis2, dis3, dis4]);
            dismax = max([dis1, dis2, dis3, dis4]);
            
            if dismin< 0.08 && dismax/long > 0.8;
                temp = [temp;handle2];
                % calculate the err of temp;
                % new coe of combined line;
                [k,b] = SS_GetCoePoly1(temp(:,1),temp(:,2));
                erryl = sum(abs(temp(:,2) -(temp(:,1) * k + b)));
                errxl = sum(abs(temp(:,1) - ((temp(:,2) - b)/k)));
                temperrl = min(erryl, errxl)/size(temp,1);
                origerr = max(LineFnl(handle1(1,6), 4 ,(handle1(1,5))) , ...
                    LineFnl(handle2(1,6), 4 ,(handle1(1,5))));
                if temperrl < origerr *1.1     % could merge
                    mergeind = 0;  % merged
                    temp(:,3) = k;
                    temp(:,4) = b;
                    % no change in temp value;
                    
                else     % not merge
                    mergeind = 1; % do not do emrge
                    temp = handle1;
                end;
                %             ln = ln+1
            else
                %             NewLines = SS_Merge(NewLines, temp,3);
                %             clear temp;
                mergeind = 1;  % didnot merged
            end;
            if mergeind
                NewLines = SS_Merge(NewLines, temp, 3);
                clear temp;
                %             else
                %                 mergeqty = mergeqty +1;
            end
        else
            NewLines = SS_Merge(NewLines, temp,3);
            mergeind = 1;
            clear temp;
        end;
        
        if ln == tbclinenum && mergeind;
            NewLines = SS_Merge(NewLines, handle2,3);
        elseif ln ==tbclinenum
            NewLines = SS_Merge(NewLines, temp, 3);
            clear temp;
        end;
        
    end;
else
    NewLines = Lines;
end;


% Merge the Arc;
if tbcarcnum >1;
    for ln = 2 : tbcarcnum ;
        handle1 = SS_RemoveZero(Arcs(:,:,ln-1));
        handle2 = SS_RemoveZero(Arcs(:,:,ln));
        
        if ~exist('temp')
            temp = handle1;
        end;
        % get some judgement information;
        
        % distance between each center;
        dcenter = norm(handle1(1,3:4) - handle2(1,3:4));
        ddeg1 = abs(handle1(1,7) - handle2(1,6));
        ddeg2 = abs(handle2(1,7) - handle1(1,6));
        ddeg = min( ddeg1, ddeg2);
        sttdeg = min(handle1(1,6) , handle2(1,6));
        edddeg = max(handle1(1,7) , handle2(1,7));
        
        if dcenter < 0.1 && ddeg<20; % meet this to consider to combine
            temp = [temp;handle2];
            % consider the new error
            [XC, YC, R, coe] = SS_GetCoeCircular(temp(:,1), temp(:,2));
            temperrcir = sqrt(sum( abs((temp(:,1) - XC).^2 + (temp(:,2) - YC).^2 - R^2) ))/size(temp(:,1),1);
            origerrcir = max(LineFnl(handle1(1,9), 4 ,(handle1(1,8))) , ...
                LineFnl(handle2(1,9), 4 ,(handle1(1,8))));
            if temperrcir < origerrcir * 1.1;
                mergeind = 0;
                temp(:,3) = XC;
                temp(:,4) = YC;
                temp(:,5) = R;
                temp(:,6) = sttdeg;
                temp(:,7) = edddeg;
            else
                % do not mergel
                temp = handle1;
                mergeind = 1;
            end;
        else
            mergeind = 1;
            %             NewArcs = SS_Merge(NewArcs, temp,3);
        end
        
        if mergeind
            NewArcs = SS_Merge(NewArcs, temp, 3);
            clear temp;
        end;
        
        if ln == tbcarcnum && mergeind;
            NewArcs = SS_Merge(NewArcs, handle2, 3);
        elseif ln == tbcarcnum;
            NewArcs = SS_Merge(NewArcs, temp, 3);
            clear temp;
        end;
    end;
else
    NewArcs = Arcs;
end;