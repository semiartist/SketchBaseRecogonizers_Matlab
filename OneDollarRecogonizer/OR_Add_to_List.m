function result = OR_Add_to_List(newGraph ,add2Index, sampleSize)
%
% THIS FUNCTION IS USED TO ROTATE THE POINTS INTO 0 DEGREE POSITION
%
%
%
%
%
%
%

% % TEST PART
% load('newGraph')
% sampleSize = 64;
% add2Index = 2;
% % end of test

% Tranform the newGraph to finalGraph
newPoints = OR_sort_Points(newGraph , sampleSize);
finalGraph = OR_transform_Graph(newPoints);
% load existing data;
load('OR_Sample_Name');
load('OR_Sample');

% take how many already existed in this sample
preExistNum = OR_Sample_Name{2,add2Index};
OR_Sample_Name(2,add2Index) = num2cell(preExistNum + 1);
% take the preexist one;

stamper = size(OR_Sample, 3);
currentSampleMtx = OR_Sample(:,:,:, add2Index);

% find the best match shape;
totalValue = 0;
    
for jumper = 1:stamper;
    currentSample = currentSampleMtx(:,:,jumper);
    missMatch = finalGraph - currentSample;
    currentValue = 0;
    for pnt = 1:pntNum;
        q = norm(missMatch(pnt,:));
        currentValue = currentValue+q;
    end;
    if jumper ==1;
        finalValue(1, 2) = currentValue;
        finalValue(1,1) = jumper;
    elseif finalValue(1, 2) > currentValue;
        finalValue(1, 2) = currentValue;
        finalValue(1,1) = jumper;
    end;
    totalValue = totalValue + currentValue;
end;

matchSample = currentSample (:,:,finalValue(1,1));

preExistGraph = matchSample * preExistNum;
newSampleGraph = (preExistGraph + finalGraph)/(preExistNum + 1);

% use the function;
newSampleMtx = OR_Create_Sample_Mtx (newSampleGraph);

%{

rotateMtx = [cosd(1) , -sind(1) , 0 ; sind(1) , cosd(1) , 0 ; 0 0 1];
rotate10 = [cosd(11) , sind(11) , 0 ; -sind(11) , cosd(11) , 0 ; 0 0 1]
newSampleGraph(:,3) = 1;
currentSample = rotate10 * newSampleGraph';

newSampleMtx = zeros(64 , 2 , 21);

for runner = 1:21;
    currentSample = rotateMtx * currentSample;
    standUp = currentSample';
    standUp = standUp(:,1:2);
    newSampleMtx (:,:,runner) = standUp;
%     plot(newSampleMtx(:,1,runner) , newSampleMtx(:,2,runner) , 'rd')
%     hold on;
end;
%}

OR_Sample(:,:,:,add2Index) = newSampleMtx;

save('OR_Sample_Name' , 'OR_Sample_Name');
save('OR_Sample', 'OR_Sample');

% END OF THE FUNCTIOn
% FEI CHEN - 3/21/16
