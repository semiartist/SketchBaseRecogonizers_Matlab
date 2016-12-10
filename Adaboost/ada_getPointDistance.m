function  disMtx = ada_getPointDistance(currentStroke)

% THIS FUNCTION IS TO USED IN THE ADABOOST GUI TO GET THE DISTANCE BETWEEN
% EACH POINT TO EACH POINT


xMtx = meshgrid(currentStroke(:,1));
yMtx = meshgrid(currentStroke(:,2));
xMtx = bsxfun(@minus, xMtx(:,1:end),currentStroke(:,1));
yMtx = bsxfun(@minus, yMtx(:,1:end),currentStroke(:,2));

disMtx = sqrt(xMtx.^2 + yMtx.^2);


