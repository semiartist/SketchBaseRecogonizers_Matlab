function result = OR_Get_Number(newGraph , sampleSize)
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

newPoints = OR_sort_Points(newGraph , sampleSize);
finalGraph = OR_transform_Graph(newPoints);
result = OR_Compare_Graph(finalGraph);

% END of the function
% FEI CHEN;
