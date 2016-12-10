function SegProp = SS_SegmentSE(MarkMtx);
%
% THIS FUNCTION IS TO GET THE START AND FINAL POINT IN A SEGMENT PNTS
%
%
%
%
%
% clear stt edd SegProp

linenum = size(MarkMtx,3);

for ln = 1: linenum;
    stt(1,1) = 1;
    sequence = find(MarkMtx(:,8,ln) ==1);
    segnum = 1;
    for sq = 2:size(sequence,1);
        if sequence(sq) - sequence(sq-1) >1;
            edd(segnum,:) = sequence(sq-1);
            stt(segnum+1,:) = sequence(sq);
            segnum = segnum +1;
        end;
    end;
    edd(segnum,:) = sequence(sq);
    if ln ==1;
        SegProp(:,:,ln) = [stt,edd];
    else
        temp = [stt,edd];
        SegProp = SS_Merge(SegProp, temp, 3);
    end;
    clear stt edd;
end;
        