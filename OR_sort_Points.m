function [newPoints] = OR_sort_Points(newGraph , sampleSize)
%
% THIS FUNCTION IS USED TO SORT THE NEW POINTS INTO EVENLY SPACED POINTS
%
%
%
%
%
%
%
%

% % TEST AREA % %
% load('newGraph');
% sampleSize = 64;
% end of test area

currentGraph = newGraph(:,1:2);

% get the length of the whole curve
lineNum = size(newGraph,1);

totalLength = 0;
for runner = 2:lineNum;
    currentLength = norm(currentGraph(runner-1,1:2) -currentGraph(runner, 1:2));
    totalLength = totalLength + currentLength;
    currentGraph(runner,3) = totalLength;
end;

unitLength = totalLength / (sampleSize-1);

newPoints = zeros(sampleSize,2);
newPoints(1,:) = currentGraph(1,1:2);
newPoints(end,:) = currentGraph(end,1:2);

for runner = 2:sampleSize-1;
    addPnt = runner-1;
    length = addPnt*unitLength;
    position = min(find(currentGraph(:,3)>=length));
    exceedLength = length - currentGraph(position-1,3);
    newPoints(runner,:) = (currentGraph(position,1:2) - currentGraph(position-1,1:2))...
        *exceedLength/(currentGraph(position,3) - currentGraph(position-1,3))...
        +currentGraph(position-1,1:2);
end;

% save( 'newPoints' , 'newPoints');

