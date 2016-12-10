function [k,b] = SS_GetCoePoly1(xvector, yvector)

%

%

[func] = fit(xvector, yvector, 'poly1');

k = func.p1;
b = func.p2;

% end of the function
% Fei Chen, 2/15/16;