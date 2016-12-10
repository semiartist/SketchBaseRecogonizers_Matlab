function TrainMeanMtx = NG_GetTrainMean(TrainData)
%
% THIS FUNCTION IS TO GET THE MEAN VALUE OF EACH FEATHRE(13 IN THIS CASE)
% OF EACH CLASS(10 IN THIS CASE), AND RETURN THE M*N MATRIX:
% M IS THE CLASSES NUMBER (1-10 IN THIS CASE) ; 
% N IS THE FEATURE NUMBER (13 IN THIS CASE);
%
%

% % TEST PART
% clear ; close ; clc;
% load('NG_TrainData')


% % % % 


featurenum = size(TrainData,2);  % 13 in this case
% samplenum = size(TrainData, 1);
classnum = size(TrainData, 3);  % 10 in this case

for runner = 1: classnum;
    classtraindata = TrainData(:,:,runner);
    classtraindata = NG_RemoveZero(classtraindata);
    samplenum = size(classtraindata,1);
    TrainMeanMtx(runner, :) = sum(classtraindata)/samplenum;
end;


% % END OF FUNCTION;
% FEI CHEN, 2/27/16