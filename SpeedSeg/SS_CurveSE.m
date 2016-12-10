function SEGMENT = SS_CurveSE(SegmentFnl);

%
% THIS FUNCTION IS TO FOR THE CURVE BETWEEN EACH SEGMENTS;
% START AND ENDING PNTS OF EACH CURVE
%
%
%
%
%


linenum = size (SegmentFnl,3);
curnum = size(SegmentFnl,1);

for ln = 1:linenum;
    for cn = 1:curnum-1; 
        if SegmentFnl(cn+1,1,ln) ~= 0;
            SEGMENT(cn,1,ln) = SegmentFnl(cn,2,ln)+1;
            SEGMENT(cn,2,ln) = SegmentFnl(cn+1,1,ln) -1;
        end;
    end;
end;
            
        
        