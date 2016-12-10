function result = ada_oneNumberOrNot(A, B)


if size(A,1) ~=2 || size(A,2)~=2 || size(B,1)~=2 || size(B,2) ~=2;
    error('position matrix should be 2x2!')
end;

xMax1 = A(1,1) ; yMax1 = A(1,2) ; xMin1 = A(2,1) ; yMin1 = A(2,2);
xMax2 = B(1,1) ; yMax2 = B(1,2) ; xMin2 = B(2,1) ; yMin2 = B(2 ,2);

parameter1 = xMax1 < xMin2 || xMax2 < xMin1 || yMax1 < yMin2 || yMax2 < yMin1;

result = parameter1;