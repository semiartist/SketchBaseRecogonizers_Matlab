function ada_adaBoostAlg(featureMtx);



% % TEST PART 
clear all; close all; clc;
load('ada_training_1_1');
class1 = featureMtx ;
load('ada_training_2_1');
class2 = featureMtx;
% end of test part;

% set some initial value:
featureNum = size(featureMtx,1);
% should change D to sample number;
D = 1/featureNum; %%%%%%%

