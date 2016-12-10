function value = NG_AddPnt(C, PntMtx)
%
% THIS FUNCTION IS TO DEFINE IF TOO ADD ONE MORE POINT TO THE PNTMTX;
%
%
%
%
%
% anglefail = 0;
lastpnt = PntMtx(end,1:2);
currentpnt = C(1,1:2);
pntnum = size(PntMtx,1);
% if pntnum >3;
%     oldangle = NG_GetAngle(PntMtx(end-1,1:2) , lastpnt);
%     angle = NG_GetAngle(lastpnt, currentpnt);
%     if abs(angle - oldangle)>90;
%         anglefail =1;
%     end;
% end;

if C(1,1)<1 && C(1,1)>0 && C(1,2)<1 && C(1,2)>0;
    if lastpnt(1) == 0 | lastpnt(2) ==0;
        value = 1;
    else
        dim = currentpnt - lastpnt;

        if norm(dim) > 0.035 %| anglefail;
            value = 1;
        else value = 0;
        end;
    end
else value = 0;
end;

% END OF FUCNTIONL
% FEI CHEN, 2/27/16