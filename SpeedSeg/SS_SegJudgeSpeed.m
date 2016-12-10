function MarkMtx = SS_SegJudgeSpeed (SpeedFail,MarkMtx,FnlMtx);
%
%
%
%
%
%
%

% % END TEST AREA
%
% load('FnlMtx')

% Get Basic Information;
linenum = size(FnlMtx, 3);
maxpntnum = size(FnlMtx,1);



% First get if there are any curvature value around this pnt;
for ln = 1:linenum;
    thislinefail = SpeedFail(:,ln);
    thislinefail = thislinefail(thislinefail~=0);
    
    for pn = 1: size(thislinefail,1);
        if MarkMtx(thislinefail(pn),3,ln) ~=1 ;
            
            % First get if there are any curvature value
            % around this pnt;
            percnt = 0;
            % The Close 2 pnts;
            if FnlMtx(thislinefail(pn)-1, 9 , ln) ~=0;
                percnt = percnt+25;
            end;
            if FnlMtx(thislinefail(pn)+1, 9 , ln) ~=0;
                percnt = percnt+25;
            end;
            % The far 4 pnts;
            if FnlMtx(thislinefail(pn)-2, 9 , ln) ~=0;
                percnt = percnt+15;
            end;
            if FnlMtx(thislinefail(pn)+2, 9 , ln) ~=0;
                percnt = percnt+15;
            end;
            if FnlMtx(thislinefail(pn)-3, 9 , ln) ~=0;
                percnt = percnt+10;
            end;
            if FnlMtx(thislinefail(pn)+3, 9 , ln) ~=0;
                percnt = percnt+10;
            end;
            MarkMtx(thislinefail(pn),4,ln) = percnt;
            
            % Then get the curvature direction
            % w.r.t the pnt;
            percnt =0;
            if FnlMtx(thislinefail(pn)-1, 8 , ln)* ...
                    FnlMtx(thislinefail(pn)+1, 8 , ln) >= 0;
                if FnlMtx(thislinefail(pn)-1, 8 , ln)* ...
                        FnlMtx(thislinefail(pn), 8 , ln) >= 0;
                    percnt = percnt +30;
                else
                    percnt = percnt - 30;
                end;
                
            else
                percnt = percnt + 25;
            end;
            
            if  FnlMtx(thislinefail(pn)-2, 8 , ln)* ...
                    FnlMtx(thislinefail(pn)-3, 8 , ln) >= 0  ...
                    && FnlMtx(thislinefail(pn)+2, 8 , ln)*  ...
                    FnlMtx(thislinefail(pn)+3, 8 , ln) >= 0 ...
                    && FnlMtx(thislinefail(pn)-2, 8 , ln)* ...
                    FnlMtx(thislinefail(pn)+2, 8 , ln) >= 0
                if  FnlMtx(thislinefail(pn)-2, 8 , ln)* ...
                        FnlMtx(thislinefail(pn), 8 , ln) >= 0
                    percnt = percnt - 30;
                else
                    percnt = percnt + 30;
                end;
            else percnt = percnt + 10;
            end;
            MarkMtx(thislinefail(pn),5,ln) = percnt;
        end;
    end;
    % To get the
    
    
end;


