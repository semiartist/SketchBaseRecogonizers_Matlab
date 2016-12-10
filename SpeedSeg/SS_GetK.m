function [ degr, type] = SS_GetK(xvector, yvector);


% % This function is to define the curvature of a curve;

length = size(xvector);
if length ~= 11;
    error('CHECK PROGRAM, ERROR IN GETK FUNCTION!')
end;
% do the linear fit first;

[k,b] = SS_GetCoePoly1(xvector,yvector);
erry = sum(abs(yvector -(xvector * k + b)));
errx = sum(abs(xvector - ((yvector - b)/k)));
arclength = norm([xvector(end), yvector(end)]-[xvector(1), yvector(1)]);
errlnr = min(erry, errx)/ arclength;
type = 1; % code 1 liner fit

% if err too big, then do circular fit;
if errlnr> 0.1;
    [XC, YC, R, coe] = SS_GetCoeCircular(xvector, yvector);
    % % THIS FEATURE TO BE BUILT;
%     % calculate error in this case;
%     erry = sum(abs(yvector -(xvector * k + b)));
%     errx = sum(abs(xvector - ((yvector - b)/k)));
%     errcirl=min(erry, errx);
%     arclength = norm(InputMtx(pn-5,1:2,ln),InputMtx(pn+5,1:2,ln));
    
    % then get slope;
    k = -1/(yvector(6)-YC) / (xvector(6)-XC);
    type = 2; % code 2 circular fit;
end;
degr = atand(k);
% dy = yvector(7) - yvector(5);
% dx = xvector(7) - xvector(5);
% if dy >=0 && dx >=0;
% 
% elseif  dx <0 ;
%     degr = atand(k) + 180;
% elseif dy <0 && dx >0;
%     degr = atan(k) + 360;
% end;


% end of the programl
% FEI CHEN. 2/15/16;