function  [ output , finalGraph] = IBR_mainFunction(pointMtx , resolution , rotateInd)
%
% This is the Main Function of the Image Based Recognizer, this function
% will sequencially run different function to get the final output
%
% Input:
% pointMtx = is a 3D matrix from input
%
% Output:
% Graph: The point matrix of whole points set
% Fei Chen,3/29
dbstop if error;
% % % % TEST AREA
% clear all; close all; clc;
% load('IBR_pointMtx');



% STEP1 - FORMAT THE IMAGE INTO 48*48(resolution) GRAPH
resolution = 48;

Graph = IBR_digitalize(pointMtx, resolution);

if rotateInd
    % STEP2 - HANDLE ROATATION
    
    result = IBR_polarRotation(Graph);
    
    % STEP3 - RECOGNIZE THE GRAPH

    [output , finalGraph] = IBR_mainMatch(result, pointMtx, resolution);

elseif rotateInd ==0;
    % GET THE MATCH WITHOUT ROTATE;
    output = IBR_noRotateMatch(Graph, resolution);
    finalGraph = Graph;
end;