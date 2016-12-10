function [XC, YC, R, coe] = SS_GetCoeCircular(xvector, yvector);
%GetCoeCircular Fits a circle in x,y plane
%
% [XC, YC, R, coe] = SS_GetCoeCircular(xvector,yvector)
% Result is center point (yc,xc) and radius R. coe return the cooefficient
% of the circle function;
% output describing the circle's equation:
% x^2+y^2+a(1)*x+a(2)*y+a(3)=0

% %(TEST)
% xvector = A(:,1);
% yvector = A(:,2);

% %

x = xvector; y = yvector;
         
n=length(x); xx=x.*x; yy=y.*y; xy=x.*y;
A=[sum(x) sum(y) n;
    sum(xy) sum(yy) sum(y);
    sum(xx) sum(xy) sum(x)];
B=[-sum(xx+yy) ; -sum(xx.*y+yy.*y) ; -sum(xx.*x+xy.*y)];
a=A\B;
XC = -.5*a(1);
YC = -.5*a(2);
R = sqrt((a(1)^2+a(2)^2)/4-a(3));
coe = a;

% End of the fucntionl
%  Fei CHen, 2/15/16;