function [SegPoints] = SS_GetTempSeg (speedfail, curfail, InputMtx)
%
% % This Function is to judge segments base on speedfail and curvature fail
% inforamtion;
% Inout:
%
% OutPut:
% SegPoints = [colume1 : 1st segpoints, column 2 : 2nd segpoints,...]

% TEST Area;
% close;  clc;
% curfail =[5;6;8;25;44;68;71;72;74];
% speedfail =[68;69;70;71;72;98;99;100;101];
% InputMtx = tbp;

%
% % % End of Test Area;

% get total pnt num;
pntnum = size (InputMtx,1);
linenum = size (InputMtx,3);


augnum = size (curfail,1);

for pns = 1:augnum ;
    lowlmt = 4; highlmt = 4;
    if curfail(pns,:) -4 <0;
        lowlmt = curfail(pns,:) -1;
    end;
    if curfail(pns,:) + 4 > pntnum;
        highlmt = pntnum - curfail(pns,:);
    end;
    aug = [curfail(pns,:)-lowlmt : curfail(pns,:) + highlmt]';
    if pns == 1;
        augcur = aug(:,1);
    else
        augcur = [augcur;aug];
    end;
end;

% get a fully confirmed seg;
% how many pnts we have here;
Seg4Sure = intersect(speedfail, augcur);   %%%% Channged the term;
pnts = size (Seg4Sure,1);

Seg = ones(5,1);

Seg(:,1) = [1:5]';
segnum = 1;   % how many seg we have;
segpnt = 5;   % how many pnt in one seg;

if pnts == 1;   % if only 1 pnt, we have 1 segment, and 1 data to add to the original one;
    if Seg4Sure(1,:) - Seg(segpnt,segnum)>0 && Seg4Sure(1,:) - Seg(segpnt,segnum)<5;   % if 6, add to the bottom of first seg;
        addnum = Seg4Sure(1,:) - Seg(segpnt,segnum);
        for addpnt = 1: addnum;
            segpnt = segpnt + 1;
            Seg(segpnt,segnum) = Seg4Sure(1,:);
        end;
        
    else    % if not within spec, add to another seg;
        segpnt = 1;
        segnum = segnum +1;
        Seg(segpnt,segnum) = Seg4Sure(1,:);
    end;   % end 1 num case;
    
else    % if have multiple pnts, then we have 'segnum' segments,
    % and each segment has 'segpnt' data;
    for pns = 1: pnts;   % add the data to Seg;
        if Seg4Sure(pns,:) - Seg(segpnt,segnum) < 5 && Seg4Sure(pns,:) - Seg(segpnt,segnum) >0;   % no need to add
            % addnum = Seg4Sure(pn,:) - Seg(segpnt,segnum) ;
            % addpnt = 1:addnum;
            segpnt = segpnt +1;
            Seg(segpnt,segnum) = Seg4Sure(pns,:);
            
        elseif Seg4Sure(pns,:) - Seg(segpnt,segnum) >  4;   % add to current Seg;
            segpnt = 1;
            segnum = segnum + 1;
            Seg(segpnt,segnum) = Seg4Sure(pns,:);
        end;
    end;
end;

% Then need to add the last 5 pnts;
if pntnum - Seg(segpnt,segnum) ~= 0 && pntnum - Seg(segpnt,segnum) > 9;
    segpnt = 1;
    segnum = segnum + 1;
    oldsize = size(Seg);
    newsize = 5;
    if oldsize(1) >= newsize;
        temp = zeros(oldsize(1),1);
        temp(1:5,:) = [(pntnum - 4) : pntnum]';
        Seg(:,segnum) = temp;
    else
        temp = zeros(newsize,oldsize(2)+1);
        temp(1:oldsize(1),1:oldsize(2)) = Seg(:,segnum-1);
        temp(newsize,oldsize(2)+1) = [(pntnum - 4) : pntnum]';
        Seg = temp;
    end
else % if Seg(segpnt,segnum) < pntnum -4
    addpnt = - Seg(segpnt,segnum) + pntnum;
    for addnum = 1:addpnt;
        addvalue = Seg(segpnt,segnum)+1;
        segpnt = segpnt +1;
        Seg(segpnt,segnum) = addvalue;
    end;
    % calculate more than 5 points;
end;

SegPoints = Seg;
% Temp output points;
% Need to add more constraint to improve the selection;

% Add more possible way;
% base on curvature points to find local speed minimal to confirm the
% points;

% construct a augmented curvature matrix;








% find if there is any points near the Seg4Sure;

% find other non-secutive points;

% judge validation;
