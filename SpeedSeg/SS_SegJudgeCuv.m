function MarkMtx = SS_SegJudgeCuv(CurFail, MarkMtx, FnlMtx , AvgSpeed);
%
%
%
%
%
%
%
%
% load ('CurFail2');
% load('MarkMtx2');
% load('FnlMtx2');
%

% Get Basic Information;
linenum = size(FnlMtx, 3);
maxpntnum = size(FnlMtx,1);

for ln = 1:linenum;
    thislinefail = CurFail(:,ln);
    thislinefail = thislinefail(thislinefail~=0);
    
    for pn = 1:size(thislinefail, 1);
        percnt = 0;
        if MarkMtx(thislinefail(pn),3,ln) ~=1 ;
            % Calculate the direction of the move;
            if thislinefail(pn)>5;
                posup = size(find(FnlMtx(thislinefail(pn)-5: thislinefail(pn)-1,8,ln)>0),1);
            else 
                posup = size(find(FnlMtx(thislinefail(pn)-3: thislinefail(pn)-1,8,ln)>0),1);
            end;
            if thislinefail(end) - thislinefail(pn) >= 5;
                posdn = size(find(FnlMtx(thislinefail(pn)+1: thislinefail(pn)+5,8,ln)>0),1);
                per1 = (posup/5) * (1-posdn/5);
                per2 = (1 - posup/5) * (posdn/5);
                percnt = max(per1, per2)*100;
            
            elseif  thislinefail(end) - thislinefail(pn) == 4;
                posdn = size(find(FnlMtx(thislinefail(pn)+1: thislinefail(pn)+4,8,ln)>0),1);
                per1 = (posup/4) * (1-posdn/4);
                per2 = (1 - posup/4) * (posdn/4);
                percnt = max(per1, per2)*100;
            else 
                posdn = size(find(FnlMtx(thislinefail(pn)+1: thislinefail(pn)+3,8,ln)>0),1);
                per1 = (posup/3) * (1-posdn/3);
                per2 = (1 - posup/3) * (posdn/3);
                percnt = max(per1, per2)*100;
            end;
                
            MarkMtx(thislinefail(pn) , 6 , ln) = percnt;
            
            % Calculate the speed influnce;
            percnt = 0;
            if FnlMtx(thislinefail(pn), 5 , ln) < AvgSpeed(1, ln) * 0.6;
                percnt = percnt +40;
            end;
            if FnlMtx(thislinefail(pn)+1, 5 , ln) < AvgSpeed(1, ln) * 0.6;
                percnt = percnt +20;
            end;
            if FnlMtx(thislinefail(pn)+2, 5 , ln) < AvgSpeed(1, ln) * 0.6;
                percnt = percnt +10;
            end;
            if FnlMtx(thislinefail(pn)-1, 5 , ln) < AvgSpeed(1, ln) * 0.6;
                percnt = percnt +20;
            end;
            if FnlMtx(thislinefail(pn)-2, 5 , ln) < AvgSpeed(1, ln) * 0.6;
                percnt = percnt +10;
            end;
            MarkMtx(thislinefail(pn) , 7 , ln) = percnt;
        end;
    end;
end;
            
