function finalGraph = OR_Square(newPoints)
%
% THIS FUNCTION IS USED TO ROTATE THE POINTS INTO 0 DEGREE POSITION
%
%
%
%

maxXY = max(newPoints);
minXY = min(newPoints);
maxX = maxXY(1) ; maxY = maxXY(2);
minX = minXY(1) ; minY = minXY(2);
xTimer = 1 / (maxX - minX) ; 
yTimer = 1/(maxY - minY);

newPoints(:,3) = 1;
newPoints = newPoints';

scalerMtx = [xTimer 0 0 ; 0 yTimer, 0 ; 0 0 1];

newPoints = scalerMtx * newPoints;

finalGraph = newPoints';

max2 = max(finalGraph);

moveX = -(max2(1) - 0.5)/2;
moveY = -(max2(2) - 0.5)/2;
moveMtx = [1 0 moveX ; 0 1 moveY ; 0 0 1];
newPoints = moveMtx * newPoints;
newPoints = newPoints';

finalGraph = newPoints(:,1:2);
