function result = OR_Create_New_List(newGraph ,newName, sampleSize)
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
% newName = 'hello kitty';
% % end of test

% Tranform the newGraph to finalGraph
newPoints = OR_sort_Points(newGraph , sampleSize);
finalGraph = OR_transform_Graph(newPoints);

% load existing data;
load('OR_Sample_Name');
load('OR_Sample');


% transfer the name to uppercase
newName = upper(newName);
newName = newName{1};

newCell = {newName ; 1};

% add name:
OR_Sample_Name = [OR_Sample_Name, newCell];


% convert data;
% rotate data to +/- 10 deg to store;
sampleNum = size(OR_Sample,4);

newSampleMtx = OR_Create_Sample_Mtx (finalGraph);

%{
rotateMtx = [cosd(1) , -sind(1) , 0 ; sind(1) , cosd(1) , 0 ; 0 0 1];
rotate10 = [cosd(11) , sind(11) , 0 ; -sind(11) , cosd(11) , 0 ; 0 0 1]
finalGraph(:,3) = 1;
currentSample = rotate10 * finalGraph';

newSampleMtx = zeros(64 , 2 , 21);

for runner = 1:21;
    currentSample = rotateMtx * currentSample;
    standUp = currentSample';
    standUp = standUp(:,1:2);
    newSampleMtx (:,:,runner) = standUp;
%     plot(newSampleMtx(:,1,runner) , newSampleMtx(:,2,runner) , 'rd')
%     hold on;
end;

% put newsample into the sample set;
%}
OR_Sample(:,:,:,sampleNum+1) = newSampleMtx;
% figure;
% for runner = 1:72
%     plot(newSampleMtx(:,1,runner) , newSampleMtx(:,2,runner) , 'k.');
%     hold on;
% end;
% 
save('OR_Sample_Name' , 'OR_Sample_Name');
save('OR_Sample', 'OR_Sample');



% END of the function
% FEI CHEN;