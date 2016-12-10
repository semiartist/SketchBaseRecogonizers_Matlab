function[ CurFail] = SS_GetCurFail(InputMtx)
%
% THIS FUNCTION IS TO GET THE CURVATURE FAIL POINTS;
%
%
%

% TEST PART;

% clear ; close ; clc;
% load('bigmtx');
% InputMtx = AugCrvMtx;

% get some preprocessing information;
clear CurFail;
linenum = size(InputMtx,3) ;
maxpntnum = size(InputMtx,1);
for ln=1:linenum;
    actpntnum(1,ln) = max(find(InputMtx(:,3,ln) ~=0));
end;

% get curvature for each line;
for ln = 1:linenum;
    ind = 1;
    % curvature(1,ln) = 0;
    for pn = 2:actpntnum(ln) ;
        if abs(InputMtx(pn,8,ln) )>5;
            CurFail(ind,ln) = pn;
            ind = ind+1;
        end;
    end;
end;
if exist('CurFail') ==0
    CurFail = zeros(1,size(InputMtx,3));
elseif size(CurFail,2) ~= size(InputMtx,3);
    CurFail = SS_Merge(CurFail, zeros(1 , size(InputMtx,3) - size(CurFail,2)) , 2);
end;

% END OF THE FUNCTION;
% FEI CHEN, 2/16/16