function [LineFnl , MarkMtx , FnlMtx  ] = SS_SegmentFn (InputMtx);
%
% This function is to get the segment for the input points matrix;
% 
% 
% 


% % % TEST PARTS;

% clear; close; clc;
% load('PntMtx1');
% InputMtx = PntMtx;

% % END OF TEST PART
hold on;

% Get Basic Information;
speedfailthreshold = 0.4;
% get size ;
linenum = size(InputMtx, 3);
maxpntnum = size(InputMtx,1);
for ln=1:linenum;
    actpntnum(1,ln) = size(SS_RemoveZero(InputMtx(:,:,ln)),1);
end;

% MAIN FUNCTION£»

% get SPEED information;
AugSpeedMtx = SS_GetSpeed (InputMtx);

% Get Curvature Information;
FnlMtx = SS_GetCurvature(AugSpeedMtx) ; 




% % Till here, this function is able to find all possible Segment Pnts;

% Then , next is to continue process the segmetn pnts, to make sure each
% set of segment pnts have no more than 5 pnts;

% Get SEGMENT pnts;
MarkMtx = SS_GetSegmentPnt (FnlMtx , speedfailthreshold);

[LineIni, MarkMtx] = SS_SegmentPostProcess(MarkMtx , FnlMtx);

% % % % what is this part used for? forget my own code/./...
% 
% for ln = 1:linenum;
%     if ln == 1;
%         SegmentPnts(:,ln) = find(MarkMtx(:,8,ln)~=0);
%     else;
%         SegmentPnts = SS_Merge( SegmentPnts, find(MarkMtx(:,8,ln)~=0),2);
%     end;
% end;


% GET SOME FITTING INFORMATION, ERROR MESSAGE OR RADIUS INFOR FOR SPLIT OR
% MERGE USE;
Line2bSplit = SS_LinePostProcess (LineIni, FnlMtx);

% try to split the line
Line2bSplit = SS_LineSplit (Line2bSplit, FnlMtx);

Line2GetDeg = SS_LineSplit (Line2bSplit, FnlMtx);

LineFnl = SS_GetSwipeDeg(Line2GetDeg,FnlMtx);
%



% TEST PLOT;
% % plot original data points;
% plot(InputMtx(1:actpntnum(2) , 1,2) , InputMtx(1:actpntnum(2) , 2,2) , 'b.');
% hold on;
% plotpnts = SegmentPnts(:,2);
% plotpnts = plotpnts(plotpnts~=0);
% plot(InputMtx(plotpnts, 1, 2) , InputMtx(plotpnts, 2, 2) , 'r*' );
