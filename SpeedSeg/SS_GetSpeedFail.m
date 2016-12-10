function [SpeedFail ,  AvgSpeed] = SS_GetSpeedFail (InputMtx , speedthreshold)
%
% THIS FUNCTION IS TO GET SPEED FAIL MATRIX FROM THE INPUT OF AUGSPEEDMTX
% 
% 
% 
% Input :
% AugSpeedMtx = should be in the SegmentFn, a n*5*m matrix, n is the max
% pntnum, m is the line number,
% Output:
% SpeedFail is a p*m matrix; p is the largest speedfail mtx, and m is the
% line number;

% TEST PART;
% close; clear; clc;
% 
% load('bigmtx');
% InputMtx = AugCrvMtx;

% END OF TEST PART

% get some preprocessing information;
linenum = size(InputMtx,3) ; 
maxpntnum = size(InputMtx,1);
for ln=1:linenum;
    actpntnum(1,ln) = max(find(InputMtx(:,3,ln) ~=0));
    % Get total time for each line;
    AvgSpeed(3,ln) = minus(InputMtx(actpntnum(1,ln),3,ln), InputMtx(1,3,ln));
end;

% Get avg speed for each line;
for ln = 1:linenum;
    AvgSpeed(2,ln) = sum(InputMtx(:,4,ln));
    AvgSpeed(1,ln) = AvgSpeed(2,ln) ./ AvgSpeed(3,ln);
end;

% From line one;
for ln = 1 : linenum;
    % assign the avg speed data to the first item of speed information
%     InputMtx(1,5,ln) = AvgSpeed(1,ln);
    % SPEED THRESHOLD IS 0.25 AVGSPEED;
    ind = 1;
    speedfail = [];
    for pn = 1:actpntnum(1,ln);
        if InputMtx(pn,5,ln) < AvgSpeed(1,ln)*speedthreshold;
            speedfail(ind,1) = pn;
            ind=ind+1;
        end;
    end;
    if ln == 1;
        SpeedFail = speedfail;
    else
        SpeedFail = SS_Merge(SpeedFail,speedfail,2);
    end;
end;
if isempty(SpeedFail);
    SpeedFail = ones(size(InputMtx,3) , 1);
end;


