clear all ; close all ; clc;


load('ada_trainFeature');

for runner = 1:size(trainFeature,3);
    trainFeatureMtxCell{runner,1} = trainFeature(:,:,runner);
    
end;

save('ada_trainFeatureMtxCell' , 'trainFeatureMtxCell');