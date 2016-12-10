function [finalvalue , rejection]  = NG_GetClass ( PntFtr)
%
% THIS FUNCTION IS TO DISCRIMINATE THE STROKE'S CLASS, WITH ITS
% POINTFEATURE VECTOR, THE COVARIANCE MATRIX (SIGMA IN THIS CASE).
%
% THIS FUNCTION MAY CONTAIN MULTIPLE FUNCTIONS TO CALCULATE THE RIGTH
% VALUE;
%
%
%
%

% % TEST CODES
% clear ; close ; clc;
% load('NG_TrainData');
% 
% load('stroke0');
% % % % END OF TEST 


% PntFtr
% % PLOAD PREEXIST DATA
load('NG_weightbyfeature');
load('NG_weightbyclass');
load('NG_invSigma');
load('NG_TrainMeanMtx')

tryvalue = weightbyclass + weightbyfeature * PntFtr';
tryvalue(1:9,2) = 1:9;
tryvalue(end,2) = 0;

% finalvalue = sortrows(valuebyclass,2);
% finalvalue1 = sortrows(valuebyclass1,2);
% finalvalue2 = sortrows(tryvalue,1);


% % CALCULATE THE POSSIBILITY TO DETERMIN THE REJECT;

for runner = 1:10;
    possibility(runner,1) =1/ sum(exp(tryvalue(1:end , 1) - tryvalue(runner ,1)));
    
end;

possibility (1:9,2) = 1:9;
possibility (end,2) = 0;

deviation = zeros(10,2);
deviation (1:9,2) = 1:9;
deviation (end,2) = 10;

for sw = 1:10;
    work = TrainMeanMtx(sw,:);
    for runner = 1:13;
        for jumper = 1:13;
            deviation(sw,1) = deviation(sw,1) + invSigma(runner, jumper )*(PntFtr(1,runner) - work(1,runner))*(PntFtr(1,jumper) - work(1,jumper));
        end;
    end;
end;

[finalvalue , rejection] = NG_Rejection(tryvalue, possibility , deviation);











