function finalGraph = OR_transform_Graph(newPoints)
%
% THIS FUNCTION IS USED TO ROTATE THE POINTS INTO 0 DEGREE POSITION
%
%
%
%
%
%
%
%

% % TEST AREA
% load('newPoints')
% end test

handr = newPoints;
handr(:,3) = 1;

% FIRST DO ROTATION
centerPoint = sum(newPoints) / size(newPoints,1);
firstPoint = newPoints(1,:);
rotateAngle = -atan2(firstPoint(:,2) - centerPoint(:,2) , firstPoint(:,1) - centerPoint(:,1));

moveMtx = [1 0 -centerPoint(1,1) ; 0 1 -centerPoint(1,2) ; 0 0 1];
rotateMtx = [cos(rotateAngle) , -sin(rotateAngle) , 0 ; sin(rotateAngle) , cos(rotateAngle), 0 ; 0 0 1];

rotateHandler = rotateMtx * moveMtx * handr';

% THEN DO SCALING;
maxXY = max(rotateHandler(1:2,:)');
minXY = min(rotateHandler(1:2,:)');

normLength = 1;
scaleX = 1/(maxXY(1) - minXY(1));
scaleY = 1/(maxXY(2) - minXY(2));

scaleMtx = [scaleX 0 0 ; 0 scaleY 0 ; 0 0 1];
scaleHandler = (scaleMtx*rotateHandler)';
newMaxXY = max(scaleHandler (:,1:2));
% newMinXY = min(scaleHandler (:,1:2));
nextMoveX = -newMaxXY(1) + 0.5;
nextMoveY = -newMaxXY(2) + 0.5;
nextMoveMtx = [1 0 nextMoveX ; 0 1 nextMoveY ; 0 0 1];

finalGraph = (nextMoveMtx * scaleHandler')';
finalGraph = finalGraph(:,1:2);
% plot(finalGraph(:,1) , finalGraph(:,2) , 'bo');
% save('finalGraph' , 'finalGraph');


% end of the function;
% FEI CHEN - MAR 21, 2016