function [LineIni, MarkMtx] = SS_SegmentPostProcess ( MarkMtx, FnlMtx);
%
% THIS FUNCTION IS TO DO POST PROCESS FOR THE INITIAL SEGMENT PNTS, TO GET
% A MORE ACCURATE SEGMENT PNTS SETS.
% THE OUTPUT MATIX ARE FINALIZED LINE LIST, TO BE RE SHAPE OF COURSE.
% 
%
%
%
%
%
%

% % TEST part
% 
% clear ; close ; clc;
% load('FnlMtx');
% load('MarkMtx')

% START OF THE FUNCTION;
linenum = size(MarkMtx,3);

SegInfo = SS_SegmentSE (MarkMtx);

% Process the SegInfo;
for ln = 1:linenum;
    process = SegInfo(:,:,ln);
    seginfo = process(process(:,1)~=0);
    seginfo(:,2) = process(1:size(seginfo,1),2);
    segnum = size(seginfo,1);
    for sg = 1:segnum;
        % case 1, 5-9 pnts in one seg;
        if seginfo(sg,2) - seginfo(sg,1) >4 && seginfo(sg,2) - seginfo(sg,1) <9;
            % fine the one who has the max curvature data;
            failnum = find(max(abs(FnlMtx(seginfo(sg,1):seginfo(sg,2) , 8 , ln ))));
            if isempty(failnum);
                failnum = [seginfo(sg,1) ; seginfo(sg,2)];
            end;
            MarkMtx(seginfo(sg,1):seginfo(sg,2) , 8 , ln) = 0;
            MarkMtx(seginfo(sg,1) - 1 +failnum , 8, ln) = 1;
            
        elseif seginfo(sg,2) - seginfo(sg,1) >9;
            % case 2, more than 9 numbers
            % direct assign first and last number to 1, the rest to 0;
            MarkMtx(seginfo(sg,1)+1:seginfo(sg,2)-1 , 8 , ln) = 0;
        end;
    end;
end;

SegmentFnl = SS_SegmentSE (MarkMtx);
LineIni = SS_CurveSE (SegmentFnl);

















