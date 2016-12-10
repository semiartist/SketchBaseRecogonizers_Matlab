function [OutMtx] = SS_GetCurvature( InputMtx )

% function information;
% THIS function is created for SpeedSeg augrithm implementation;
% input
% InputMtx = is the AugPntMtx;
% 
% Output:
% SpeedMtx = the matrix contains speed of each points;
% AverageSpeedMtx

% % END OF TEST PART;
linenum = size(InputMtx, 3);
maxpntnum = size(InputMtx,1);

for ln = 1:linenum;
    % get non-zero pnts qty
    nz = max(find((InputMtx(:,3,ln))~=0));
    % case 1, nz < 11;
    if nz <11; % lnr sqr fit;
        [k,b] = SS_GetCoePoly1(InputMtx((1:nz),1,ln),(InputMtx((1:nz),2,ln)));
        % assign angle to 6th column;
        InputMtx(1:nz,6,ln) = atand(k);
        
    else % case 2, nz >11;
        % for the first 5 pnt, do lnr sqr fit, 4 times
        for pn = 2:5;
            [k,b] = SS_GetCoePoly1(InputMtx(pn-1:pn+1,1,ln),(InputMtx(pn-1 : pn+1,2,ln)));
            InputMtx(pn,6,ln) = atand(k);
        end;
        InputMtx(1:5,7,ln) = 1;
        InputMtx(1,6,ln) =InputMtx(2,6,ln) ;
        
        % lnr sqr fit;
        % start from the 6th pnt, and end at nz -5 pnt
        for pn = 6 : nz-5;
            xvector = InputMtx((pn-5:pn+5),1,ln); yvector = InputMtx((pn-5:pn+5),2,ln);
            % do fit first;
            [degr, loc] = SS_GetK(xvector, yvector);
            
            % write in matrix;
            InputMtx(pn,6,ln) = degr;
            InputMtx(pn,7,ln) = loc;   % linear or circular;
        end;
        
        % for the last 5 pnt, do lnr sqr fit, 4 times
        for pn = nz-4:nz-1;
            [k,b] = SS_GetCoePoly1((InputMtx(pn-1:pn+1,1,ln)) ,(InputMtx(pn-1 : pn+1,2,ln)));
            InputMtx(pn,6,ln) = atand(k);
        end;
        InputMtx(nz,6,ln) =InputMtx(nz-1,6,ln) ;
        InputMtx(nz-4:nz,7,ln) = 1;
        % dosnt matter to lnr or circular, will mark as start and finishing
        % pnts;
        
    end;
end;

% get curvature for each line;
for ln = 1:linenum;
    nz = max(find((InputMtx(:,3,ln))~=0));
    % ind = 1;
    % curvature(1,ln) = 0;
    for pn = 2:nz ;
        InputMtx(pn,8,ln) = 0.001*(InputMtx(pn,6,ln) - InputMtx(pn-1,6,ln))/InputMtx(pn,4,ln);
        if abs(InputMtx(pn,8,ln) )<5;
            InputMtx(pn,9,ln) = 0;
        else
            InputMtx(pn,9,ln) = abs(InputMtx(pn,8,ln) );
            % CurFail(ind,ln) = pn;
            % ind = ind+1;
        end;
        
    end;
end;

OutMtx = InputMtx;

% output, use another fnc to calculate the seg pnts.

% End of the function;
% FEI CHEN, 2/15/16

