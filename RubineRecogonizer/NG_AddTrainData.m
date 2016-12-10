function TrainData = NG_AddTrainData(TrainData, PntFtr , truevalue)

%
%
%
%
%
%
%
%

% % % TEST PART
% truevalue = 3;
% % load('TrainData')



currenttrain = TrainData(:,:,truevalue);

if  all(currenttrain(1,:) ==0)
    TrainData(1,:,truevalue) = PntFtr;
else
    currenttrain = NG_RemoveZero(currenttrain);
    trainnum = size(currenttrain, 1);
    TrainData(trainnum+1 , : , truevalue) = PntFtr;
end;

% END OF THE FUNCTION
% FEI CHEN, 2/27/16