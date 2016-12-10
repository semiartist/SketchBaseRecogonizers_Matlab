function Graph = IBR_digitalize(pointMtx, n)

% 
% THIS FUNCTION IS TO TURN THE STROKE INTO A N*N MATRIX OF BIT IMAGE
%
%
%
%

% TEST AREA
% clear all; close all; clc;
% load('IBR_pointMtx2');
% n = 48;

% n is the resolution of the image, choose from 48,256,1024...

% STEP1 - Combine Stroke;
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

% STEP2 - Normalize
maxXY = max(totalPoints); minXY = min(totalPoints);
width = maxXY(1,1) - minXY(1,1);
height = maxXY(1,2) - minXY(1,2);
moveDis = abs(width - height)/2;

totalPoints(:,1) = totalPoints(:,1) - minXY(1,1);
totalPoints(:,2) = totalPoints(:,2) - minXY(1,2);

if width >= height;
    sideLength = width;
    totalPoints(:,2) = totalPoints(:,2)+ moveDis;
else 
    sideLength = height;
    totalPoints(:,1) = totalPoints(:,1) + moveDis;
end;

totalPoints = totalPoints*(n-1)/sideLength;

 Graph = unique(round(totalPoints), 'rows');
%  Graph = round(totalPoints);
%{
for runner = 1:size(finalPoints,1);
    Graph(finalPoints(runner,1)+1,finalPoints(runner,2)) = 1;
end;
%}