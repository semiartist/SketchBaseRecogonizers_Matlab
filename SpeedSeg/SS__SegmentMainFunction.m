function [SegMtx] =  SS_SegmentMainFunction()
% This FUNCTION is to determin the segment points in the augmented curve
% matrix, which included the information of speed, curvature.
% eliminate the first 5 and last 5 pnts when doing the segmentation;


% TEST AREA
clear ; close ; clc;


InputMtx = C;

% % END OF TEST AREA

% Start of the function;
% get some basic matrix information;
linenum = size(InputMtx,3);
maxpntnum = size(InputMtx,1);


% calculate average stroke
for ln = 1: linenum;
    nz = max(find((InputMtx(:,3,ln))~=0));
    
    % get all points from this line;
    % come up with a matrix to-be-process
    tbp = InputMtx((1:nz),:,ln);
    
    % total arc length
    totalarcl= sum(tbp(:,4));
    % total time;
    totaltime = tbp(nz,3) - tbp(1,3);
    % Average Speed
    avgspeed = totalarcl / totaltime;
       
    speedfail = find(tbp(:,5) < 0.25*avgspeed);
    
    % get curvature information ;
    for pn = 2:nz;
        crvtr = abs(0.001* (tbp(pn,6) - tbp(pn-1,6)) / tbp(pn,4));
        if abs(crvtr) < 5;
            crvtr = 0;
        end;
        curvature (pn,:) = crvtr;
    end;
    curfail = find(curvature~=0);
    
    if nz < 20;
        % if the line points smaller than 20, catogry it as a whole line;
        Segment = [1:nz]';
    else
        % if the line points more than 20, then do the fine segment
        % process;
        linesegment = SS_GetTempSeg(speedfail, curfail, tbp);
    end;
    
    if ln ==1;
        Seg(:,:,ln) = linesegment;
    else
        nowsize = size(linesegment);
        presize = size(Seg);
        if presize(1) >= nowsize(1) && presize(2) >= nowsize(2);
            enlar = zeros(presize(1), presize(2));
            enlar((1:nowsize(1)),(1:nowsize(2))) = linesegment;
            Seg(:,:,ln) = enlar;
        elseif presize(1) <= nowsize(1) && presize(2) <= nowsize(2);
                enlar3 = zeros(nowsize(1), nowsize(2),ln);
                enlar3(1:presize(1),1:presize(2),1:ln-1) = Seg(:,:,1:ln-1);
                enlar3(:,:,ln) = linesegment;
                Seg = enlar3;
        else 
            newsize(1) = max(nowsize(1), presize(1)) ;
            newsize(2) = max(nowsize(2),presize(2));
            newsize = [newsize(1), newsize(2)];
            enlar2 = zeros(newsize(1), newsize(2));
            enlar2(1:presize(1), 1:presize(2), 1:ln-1) = Seg(:,:,1:ln-1);
            enlar2(1:nowsize(1),1:nowsize(2),ln) = linesegment;
            Seg = enlar2;
            
        end;
    end;
end

  SegMtx = Seg;
