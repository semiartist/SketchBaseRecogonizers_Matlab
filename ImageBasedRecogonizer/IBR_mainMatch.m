function [output , outGraph] = IBR_mainMatch(result, pointMtx, resolution)

% THIS FUNCTION IS TO DO THE MATCHING AFTER THE ROTATEIONL TAKE SEVERAL
% THINGS AS INPUT, AND THE FINAL RESULT AS OUTPUT;
% 
% INPUTS:
% result = result from step2, which is the possibility and the rotation
%          degree
% pointMtx = the input pointMtx from main function
% resolution = resolution of the pixel from input;
%
% OUTPUTS:
% output whihc is a number of the recognize result. used to plot final
% result on the graph;

% % TEST AREA % %
% dbstop if error;
% clear all; close all; clc;
% load('IBR_pointMtx');
% resolution = 48;
% result = [3.0000    1.0472;  5.0000    0.7854 ;8.0000    0.2618];

% end test;

possibility = size(result,1);


% PREPROCESSING POINTS
strokeNum = size(pointMtx,3);
pntNum = size(pointMtx,1);
for layer = 1:strokeNum;
    % for each layer;
    currentLayer = pointMtx(:,1:2,layer);
    currentLayer = IBR_removeZero(currentLayer);
    if layer ==1;
        totalPoints = currentLayer;
    else 
        totalPoints = [totalPoints; currentLayer];
    end
end;

pointMtx = totalPoints;
pointMtx(:,3) = 1;
% use below method to compare different orientation and stuff;
for runner = 1: possibility;
    rotateMtx = [cos(result(runner,2)), -sin(result(runner,2)), 0; ...
        sin(result(runner,2)), cos(result(runner,2)) , 0 ; 0 , 0 , 1 ];
    currentPMtx = (rotateMtx * pointMtx.').';
    
    Graph = IBR_digitalize(currentPMtx, resolution);
    tempInd(:,runner) = IBR_matchingFunction(Graph, resolution, result(runner,1));
    graphStore(1:length(Graph) , : , runner) = Graph;
end;
Haus = tempInd(1 , :);
modiHaus = tempInd(2 , :);
tanimoto =tempInd(3 , :);
yule = tempInd(4 , :);


% TRANSFORM THE 4 COEFFICNET TO RIGHT ORIENTATION;
% for Haus
minHaus = min(Haus); maxHaus= max(Haus);
finalHaus = (Haus-minHaus)/(maxHaus - minHaus );
% for modified Haus
minModiHaus = min(modiHaus) ; maxModiHaus=max(modiHaus);
finalModiHaus = (modiHaus - minModiHaus)/(maxModiHaus - minModiHaus);
% for tanimoto
minTani = min(tanimoto) ; maxTani = max(tanimoto);
finalTani = (tanimoto - minTani)/(maxTani - minTani);
%for Yule
minYule = min(yule) ; maxYule = max(yule);
finalYule = (yule - minYule)/(maxYule - minYule);

weight = -finalHaus -finalModiHaus + finalTani + finalYule;
[~ , index] = max(weight);

outGraph = IBR_removeZero(graphStore(:,:,index));
output = result(index,1);