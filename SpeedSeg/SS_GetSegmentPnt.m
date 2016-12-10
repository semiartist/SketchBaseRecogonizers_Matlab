function MarkMtx = SS_GetSegmentPnt (FnlMtx , speedfailthreshold)
%
%
%
%
% TEST AREA
%  clear; close; clc;
% load ('FnlMtx')
% FnlMtx =FnlMtx(:,:,2);
% load('FnlMtx');
% InputMtx = FnlMtx;

% % END TEST AREA
linenum = size(FnlMtx, 3);
maxpntnum = size(FnlMtx,1);
for ln=1:linenum;
    actpntnum(1,ln) = max(find(FnlMtx(:,3,ln) ~=0));
end;

% bfail = 0;

% % Get Speed Fail;
 [SpeedFail , AvgSpeed ]= SS_GetSpeedFail(FnlMtx, speedfailthreshold);

% % Get CurFail;
% Get CurvatureFail;
CurFail = SS_GetCurFail(FnlMtx);
CurFail = [ones(1 , linenum) ; CurFail];

% Find BothFail
% Find GenFail;  % Fail either on of them;
for ln = 1: linenum;
    clear current;
    gfail= unique([CurFail(:,ln) ; SpeedFail(:,ln)]);
    gfail(gfail(:) ==0) = [];
    current = intersect(CurFail(:,ln) , SpeedFail(:,ln));
    if isempty(current);
        bfail = ones(1,1);
    else
        current(current==0) = [];
        bfail = current;
    end;
        
    if ln == 1;
        GenFail = gfail;
        BothFail = bfail;
    else
        GenFail = SS_Merge(GenFail, gfail, 2);
        BothFail = SS_Merge(BothFail, bfail, 2);
    end;
end;

% Class A points are fail both
% These points are must been marked as break points
% Create a MarkMtx to store the pnt property;
MarkMtx = zeros(size(FnlMtx,1),3, size(FnlMtx,3));
% MarkMtx with pnt#, Pnt Fitting Type and it's 
for ln = 1: linenum;
    MarkMtx(1:actpntnum(ln),1,ln) = 1:actpntnum(ln);
    MarkMtx(:,2,ln) = FnlMtx(:,7,ln);
    % Mark TypeA points;
    if BothFail(:,ln) ~=0;
        MarkMtx(BothFail(:,ln),3,ln) = 1;
    end;
    % Mark Type B points;
    if SpeedFail(1,ln) ~=0;
        marknum = SpeedFail(:,ln);
        MarkMtx(marknum(marknum~=0),3,ln) = 2;
    end;
    
    % Mark Type C points;
    if CurFail(1,ln) ~=0;
        marknum = CurFail(:,ln);
        MarkMtx(marknum(marknum~=0),3,ln) = 3;
    end;
    
    % So the mark 1 is the segment points for sure, 2 or 3 need to be
    % further analysis. And 0 are just normal points;  
    
    % First Define the first and last 3 pnts as segments;
    MarkMtx(1:3,3,ln) = 1;
    MarkMtx(actpntnum(ln)-2:actpntnum(ln),3,ln) = 1;  
end;


% Class B points are failed speed, not fail curve;
% then lower the standard on cur to see if it fails;
% Get first possibility, to see if speedfail around have any curfail ;
MarkMtx = SS_SegJudgeSpeed (SpeedFail,MarkMtx,FnlMtx);

% class C points are failed curve, not fail speed;
MarkMtx = SS_SegJudgeCuv(CurFail, MarkMtx, FnlMtx , AvgSpeed);
% to see the line fit model of pre and after points, if all are same, to
% get a big fit, if fail smaller than 10%, or radius smaller than some
% value, then mark as a long arc, else break;

% Then sorting the MarkMtx;
for ln = 1: linenum;
    thislinefail = MarkMtx(:,3,ln);
    thislinefail = find(thislinefail~=0);
    
    for pn = 1:size(thislinefail, 1);
        if MarkMtx(thislinefail(pn),3,ln) ==1;
            MarkMtx(thislinefail(pn),8,ln) =1;
        elseif MarkMtx(thislinefail(pn),3,ln) ==2;
            if MarkMtx(thislinefail(pn),4,ln) + MarkMtx(thislinefail(pn),5,ln) >18/speedfailthreshold;
                MarkMtx(thislinefail(pn),8,ln) =1;
            end;
        elseif MarkMtx(thislinefail(pn),3,ln) ==3;
            if MarkMtx(thislinefail(pn),6,ln) + MarkMtx(thislinefail(pn),7,ln) >110 ...
                    | MarkMtx(thislinefail(pn),6,ln)>=60 | MarkMtx(thislinefail(pn),7,ln)>=60;
                MarkMtx(thislinefail(pn),8,ln) =1;
            end;
        end;
        % Get the Segment Mtx;
        % Conenct the fails;
        if pn>3 && pn<actpntnum(1,ln)-2 && MarkMtx(thislinefail(pn),8,ln) ==1;
            connect = min(find(MarkMtx(thislinefail(pn)-3:thislinefail(pn)-1,8,ln)));
            if connect~=0;
                MarkMtx(thislinefail(pn)-3+connect:thislinefail(pn),8,ln) = 1;
            end;
        end;
    end;
end;

% Form a new matrix for storage the data points and 




