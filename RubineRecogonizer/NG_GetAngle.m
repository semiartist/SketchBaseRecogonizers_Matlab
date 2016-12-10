function angle =  NG_GetAngle(lastpnt, currentpnt);
%
%
%
%
%
%
%
%
%

dx = currentpnt(1,1) - lastpnt(1,1);
dy = currentpnt(1,2) - lastpnt(1,2);

angle = atand(dy/dx);

if dx <0;
    angle = angle +180;
elseif dy<0;
    angle = angle +360;
end;


% END OF FUNCTION
% FEI CHEN 2/27/16