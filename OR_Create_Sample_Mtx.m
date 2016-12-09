function newSampleMtx = OR_Create_Sample_Mtx (currentSample)
%
% THIS FUNCTION IS USED TO ROTATE THE POINTS INTO 0 DEGREE POSITION
%
%
%
%
%
%
%

% convert data;
% rotate data to +/- 10 deg to store;
% sampleNum = size(OR_Sample,4);

rotateMtx = [cosd(5) , -sind(5) , 0 ; sind(5) , cosd(5) , 0 ; 0 0 1];
% rotate10 = [cosd(11) , sind(11) , 0 ; -sind(11) , cosd(11) , 0 ; 0 0 1]
currentSample(:,3) = 1;
% currentSample = rotate10 * finalGraph';
currentSample = currentSample';

newSampleMtx = zeros(64 , 2 , 21);
% figure
for runner = 1:72;
    currentSample = rotateMtx * currentSample;
    standUp = currentSample';
    standUp = standUp(:,1:2);
%     finalShape = OR_transform_Graph(standUp);
    newSampleMtx (:,:,runner) = standUp;
%     plot(newSampleMtx(:,1,runner) , newSampleMtx(:,2,runner) , 'rd')
%     hold on;
end;

% figure
for runner = 1:72;
    newSampleMtx(:,:,runner) = OR_Square(newSampleMtx(:,:,runner));
%     plot(newSampleMtx(:,1,runner) , newSampleMtx(:,2,runner) , 'k.');
%     hold on;
end;