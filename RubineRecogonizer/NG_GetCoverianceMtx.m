function [weightbyclass , weightbyfeature , TrainMeanMtx] = NG_GetCoverianceMtx (TrainData)

%
% THIS FUNCTION SHOULD TEST WITH GET_TRAINMEAN FUNCTION, AND THIS FUNCTION
% IS TO GET THE TRUE SIGMA TO CALCULATE THE DISCRIMINATE FUNCTION
%
%
%
%
%
%


TrainMeanMtx = NG_GetTrainMean(TrainData);


featurenum = size(TrainData,2);  % 13 in this case
classnum = size(TrainData, 3);  % 10 in this case
PreSigma= zeros(featurenum, featurenum, classnum);



totalsamplenum = 0;

for jumper = 1:classnum;
    classtraindata = TrainData(:,:,jumper);
    classtraindata = NG_RemoveZero(classtraindata);
    samplenum = size(classtraindata,1);
    totalsamplenum = totalsamplenum + samplenum;
    classmean = TrainMeanMtx(jumper,:);
    for runner = 1:samplenum;
        for row = 1:featurenum ;
            for col = 1:featurenum ;
                currentvalue = (classtraindata(runner,row) - classmean(1,row)) * (classtraindata(runner,col) - classmean(1,col));
                PreSigma(row,col,jumper) = PreSigma(row,col,jumper)+currentvalue;
            end;
        end;
    end;
end;

[linenum, colnum , classnum ] = size(PreSigma );


for runner = 1:linenum;
    for jumper = 1:colnum;
        Temp(runner,jumper) = sum(PreSigma(runner, jumper,:));
    end;
end;


Sigma = Temp / ((-classnum) +  totalsamplenum );
invSigma = inv(Sigma);
save('NG_invSigma','invSigma');

weightbyfeature = zeros(10,13);

for runner = 1:classnum;
    for jumper = 1:featurenum ;
        weightbyfeature(runner,:) = weightbyfeature(runner,:) + invSigma(jumper,:)*TrainMeanMtx(runner,jumper);
    end;
end;


weightbyclass = zeros(10,1);

for runner = 1:classnum;
    for jumper = 1:featurenum;
        weightbyclass(runner, 1) = weightbyclass(runner, 1) -0.5*weightbyfeature(runner,jumper)*TrainMeanMtx(runner,jumper);
    end;
end









