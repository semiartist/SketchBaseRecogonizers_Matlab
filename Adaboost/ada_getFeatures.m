function totFeatMtx = ada_getFeatures(pointMtx)

% THIS FUNCTION IS USED TO ABSTRACT FEATURES FROM THE PENSTROKES,
% IMPLEMENTED IN ADABOOST ALGORITHM.
%
% INPUT:
%       pointMtx = 3D matrix which discribed the point features,[x, y, time]
%
% OUTPUT:
%       not defined yet;
%
% FEI CHEN - 4/21/16;

%% Start of Program
% % TEST AREA % %
% clear all ; close all; clc;
% load('ada_pointMtx');
% tic
% dbstop if error;

% % end of test area;

%% PREDEFINED PARAMETER
cuspIndex = 60;
totalPointMtx = zeros(1,2);
[maxPointNum, ~ , strokeNum] = size(pointMtx);
% strokeNum = 1;
% FEATURE 1: NUM OF STROKES;
featureMtx(1,1:strokeNum) = strokeNum;
%% BELOW NEED TO CALCULATE FOR EACH STROKE INDIVIDUALLY
for sn = 1: strokeNum;
    totalPointMtx = [totalPointMtx ; pointMtx(:,1:2,sn)];
    %% initialize data used in loop;
    clear cusp2End pointNum cuspLoc cuspNum cuspMtx vectorL indVector strokeL pointNum cuspLoc cuspNum
    clear currentStroke angleHist
    xMaxNum = 0;yMaxNum = 0; xMinNum = 0; yMinNum = 0;
    
    % end of initialize
    %% GET SOME BASIC INFORMATION
    %     currentStroke = ada_removeZero(pointMtx(:,:,sn));
    currentStroke = pointMtx(:,:,sn);
    currentStroke(currentStroke(:,1) ==0,:) = [];
    pointNum(sn,1) = size(currentStroke,1);
    
    % calculate stroke length;
    currentStroke(2:end,4:5)= diff(currentStroke(:, 1:2));
    currentStroke(1,4:5) = 0;
    strokeL = sum(sqrt( currentStroke(:,4).^2 + currentStroke(:,5).^2));
    
    %% 3.1.2 BELOW PART TO FIND CASP
    currentStroke(:,6) = (atan2d(currentStroke(:,5) ,currentStroke(:,4)));  %% test on this line
    avgStrokeDeg =mean( [currentStroke(1:end-4, 6) ,currentStroke(2:end-3,6)...
        ,currentStroke(3:end-2,6),currentStroke(4:end-1,6),currentStroke(5:end,6) ],2);
    currentStroke(:,6) = [avgStrokeDeg(1,1);avgStrokeDeg(1,1);avgStrokeDeg ; avgStrokeDeg(end,1);avgStrokeDeg(end,1)];
    currentStroke(2:end,7) = abs(diff(abs(currentStroke(:,6))));
    cuspLoc = find(currentStroke(:,7)>cuspIndex);
    cuspLoc(cuspLoc<6) = [];
    cuspLoc(cuspLoc>pointNum(sn,1)-5) = [];
    if isempty(cuspLoc)
        cuspLoc = 0;
        cuspNum = 0;
    else
        cuspNum = size(cuspLoc,1);
        cuspMtx = currentStroke(cuspLoc,1:2);
    end;
    % if there is only 1 cusp;
    if cuspNum==0;
        featureMtx(3,sn) =0;
        featureMtx(4,sn) = 0;
        featureMtx(5,sn) = 0;
        featureMtx(6,sn) = 0;
    else
        for cuspN1 = 1:cuspNum;
            for cuspN2 = 1:cuspNum;
                cuspDis(cuspN1,cuspN2) = norm(cuspMtx(cuspN1,:) - cuspMtx(cuspN2,:));
            end;
            cusp2F = norm(cuspMtx(cuspN1,1:2) - currentStroke(1,1:2));
            cusp2E = norm(cuspMtx(cuspN1,1:2) - currentStroke(end,1:2));
            if cuspN1 ==1;
                cusp2EndMax = max(cusp2F, cusp2E);
                cusp2EndMin = min(cusp2F, cusp2E);
            else
                cusp2EndMax = max(cusp2EndMax,max(cusp2F, cusp2E));
                cusp2EndMin = min(cusp2EndMin,min(cusp2F, cusp2E));
            end;
        end;
        
        cuspDis(cuspDis==0) = [];
        % CUSP FEATURES:
        if isempty(cuspDis)
            cuspDis = 0;
        end;
        featureMtx(3,sn) = max(max(cuspDis))/strokeL;
        featureMtx(4,sn) = min(cuspDis)/strokeL;
        featureMtx(5,sn) = cusp2EndMax/strokeL;
        featureMtx(6,sn) = cusp2EndMin/strokeL;
    end % if for cuspNum
    featureMtx(2,sn) = cuspNum;
    
    %% 3.1.3 BELOW PART TO FIND RATIO;
    featureMtx(7,sn) = min(currentStroke(:,1));
    featureMtx(8,sn) = max(currentStroke(:,1));
    featureMtx(9,sn) = min(currentStroke(:,2));
    featureMtx(10,sn) = max(currentStroke(:,2));
    
    %{
    %% 3.1.4 BELOW PART TO FIND INTERSECTION FEATURES;
    disMtx = ada_getPointDistance(currentStroke);
    interSect = ada_findIntersection( disMtx, currentStroke);
    if interSect(1,1) ==0;
        featureMtx(11,sn) = 0; % intersect number;
        featureMtx(12,sn) = 0; % min value between each intersect
        featureMtx(13,sn) = 0; % max value between each intersect
        featureMtx(14,sn) = 0; % min value between intersect to end
        featureMtx(15,sn) = 0; % max value between intersect to end;
        clear interSect;
    else
        featureMtx(11,sn) = size(interSect,1); % intersect number;
        interSectDist = ada_getPointDistance(interSect);
        featureMtx(12,sn) = max(max(interSectDist)); % min value between each intersect
        featureMtx(13,sn) = min(min(interSectDist)); % max value between each intersect
        interDis2F = [bsxfun(@minus, interSect,  currentStroke(1,1:2)); bsxfun(@minus, interSect,  currentStroke(end,1:2))];
        featureMtx(14,sn) = max(sqrt(sum(interDis2F.^2 , 2))); % min value between intersect to end
        featureMtx(15,sn) = min(sqrt(sum(interDis2F.^2 , 2))); % max value between intersect to end;
        clear interSectDist interDis2F;
    end;
    %}
    
    %% 3.1.7 FIRST AND LAST DISTANCE;
%     featureMtx(16,sn) = norm(currentStroke(1,1:2) - currentStroke(end,1:2));
    
    %% 3.1.8 ARC LENGTH
    featureMtx(17,sn) = strokeL;
    
    %% 3.1.11 STROKE AREA
    areaVector = bsxfun(@minus, currentStroke(2:end,1:2) , currentStroke(1,1:2));
    areaVector(2:end,3) = diff(atan2(areaVector(:,1) , areaVector(:,2)));
    areaVector(:,4) = sqrt(sum(areaVector(:,1:2).^2 , 2));
    areaVector(2:end,5) = areaVector(1:end-1,4);
    areaVector(:,6) = abs(areaVector(:,3).*areaVector(:,4).*areaVector(:,5));
    featureMtx(18,sn) = sum(areaVector(:,6))/pointNum(sn,1);
    
    %% 3.1.6 ANGLE HISTOGRAM
    angleHist(1,1) = size(find(currentStroke(:,6) > 135),1);% consider using the 6th colume information as the angle of the vector;
    angleHist(2,1) = size(find(currentStroke(:,6) > 90),1)- angleHist(1,1);
    angleHist(3,1) = size(find(currentStroke(:,6) > 45),1) - angleHist(2,1)-angleHist(1,1);
    angleHist(4,1) = size(find(currentStroke(:,6) > 0),1)- angleHist(3,1) - angleHist(2,1) - angleHist(1,1);
    angleHist(5,1) = size(find(currentStroke(:,6) <-135),1);
    angleHist(6,1) = size(find(currentStroke(:,6) <-90),1)-angleHist(5,1);
    angleHist(7,1) = size(find(currentStroke(:,6) <-45),1)-angleHist(5,1)-angleHist(6,1);
    angleHist(8,1) = size(find(currentStroke(:,6) <=0),1)-angleHist(5,1)-angleHist(6,1)-angleHist(7,1);
    featureMtx(19:26,sn) = angleHist;
    
    %% 3.1.9 FIT LINE FEATURE
    
    %% 3.1.10 DOMINANT POINT FEATURE
    % first get the dominant points;
    avgX =mean( [currentStroke(1:end-4, 1) ,currentStroke(2:end-3,1)...
        ,currentStroke(3:end-2,1),currentStroke(4:end-1,1),currentStroke(5:end,1) ],2);
    avgY =mean( [currentStroke(1:end-4, 2) ,currentStroke(2:end-3,2)...
        ,currentStroke(3:end-2,2),currentStroke(4:end-1,2),currentStroke(5:end,2) ],2);
    %     operation = currentStroke(:,6);
    %     operation(operation>90) = operation(operation>90) - 90;
    %     operation(operation<-90) = operation(operation<-90) + 90;
    [~,xLocPos] = findpeaks(avgX);
    [~,xLocNeg] = findpeaks(-avgX);
    [~,yLocPos] = findpeaks(avgY);
    [~,yLocNeg] = findpeaks(-avgY);
    domIndex = sort([xLocPos ; xLocNeg; yLocPos ; yLocNeg]);
    potential = find(diff([0;domIndex])>=5);
    domIndex = [1;domIndex(potential);pointNum(sn,1)];
    domPoints =  currentStroke(domIndex,:) ;
    domPoints(:,3) = domPoints(:,6);
    domPoints(domPoints(:,3)<0,3) = domPoints(domPoints(:,3)<0,3) + 180;
    if exist('totDomPoints')
        totDomPoints = [totDomPoints ; domPoints(:,1:2)];
    else
        totDomPoints = domPoints(:,1:2);
    end;
    featureMtx(27,sn) = max(domPoints(:,3));
    if size(domPoints, 1) <3;
        featureMtx(28,sn) = 0;
        featureMtx(29,sn) = 0;
        featureMtx(30,sn) = 0;
    else
        featureMtx(28,sn) = sum(diff(domPoints(2:end-1,3)))/(size(domIndex,1)-2);
        featureMtx(29,sn) = size(find(abs(diff(domPoints(2:end,3)))<3),1);
        featureMtx(30,sn) = size(find(bsxfun(@times,domPoints(1:end-1,6),domPoints(2:end , 6))<0),1);
    end;
    
    %% 3.1.14 MIN AND MAX FEATURES
    % for x values:
    % the starting direction;
    if avgX(5,1) - avgX(1,1) <0;
        featureMtx(35,sn) = -1;
        xMaxNum = xMaxNum + 1;
    else
        featureMtx(35,sn) = 1;
        xMinNum = xMinNum + 1;
    end;
    % the ending direction
    if avgX(end,1) - avgX(end-4,1) <0;
        featureMtx(36,sn) = -1;
        xMaxNum = xMaxNum + 1;
    else
        featureMtx(36, sn) = 1;
        xMinNum = xMinNum +1;
    end;
    % the max and min value;
    xMaxs =sort([xLocPos ; xLocNeg]);
    if ~isempty(xMaxs)
        featureMtx(37,sn) = xMaxs(end)/pointNum(sn,1);
    else
        featureMtx(37,sn) = 0;
    end;
    xMaxNum = xMaxNum + size(xLocPos,1);
    xMinNum = xMinNum + size(xLocNeg,1);
    featureMtx(38,sn) = xMaxNum;
    featureMtx(39,sn) = xMinNum;
    
    % for y values:
    % the starting direction;
    if avgY(5,1) - avgY(1,1) <0;
        featureMtx(40,sn) = -1;
        yMaxNum = yMaxNum + 1;
    else
        featureMtx(40,sn) = 1;
        yMinNum = yMinNum + 1;
    end;
    % the ending direction
    if avgY(end,1) - avgY(end-4,1) <0;
        featureMtx(41,sn) = -1;
        yMaxNum = yMaxNum +1;
    else
        featureMtx(41, sn) = 1;
        yMinNum = yMinNum + 1;
    end;
    % the max and min value;
    yMaxs =sort([yLocPos ; yLocNeg]);
    if ~isempty(yMaxs)
        featureMtx(42,sn) = yMaxs(end)/pointNum(sn,1);
    else
        featureMtx(42,sn) =0;
    end;
    yMaxNum = yMaxNum + size(yLocPos,1);
    yMinNum = yMinNum + size(yLocNeg,1);
    featureMtx(43,sn) = yMaxNum;
    featureMtx(44,sn) = yMinNum;
    
    %% %% Below features will be taken with multiple strokes
   
    %% test code in loop;
    %     testvalue = sum(norm(currentStroke(2:end,4:5)))
%     disp('TEST PART')

    
    %
%     plot(currentStroke(:,1) , currentStroke(:,2),'r.');

%     plot(domPoints(:,1) , domPoints(:,2), 'k*')
%     clear interSect
    %     currentStroke
end ; % end the stroke number feature calculation

%% CALCULATE FEATURES THAT REQUIRE TO CALCULATE IN GENERAL;
% combine a larger pointmatrix;
totalPointMtx(totalPointMtx(:,1) ==0,:) = [];
% generate features matrix
totFeatMtx(1,1) = mean(featureMtx(1,:),2);
totFeatMtx(2,1) = sum(featureMtx(2,:));
totFeatMtx(3,1) = max(featureMtx(3,:));
totFeatMtx(4,1) = min(featureMtx(4,:));
totFeatMtx(5,1) = max(featureMtx(5,:));
totFeatMtx(6,1) = min(featureMtx(6,:));
totFeatMtx(7,1) = (max(featureMtx(8,:)) - min(featureMtx(7,:)))/(max(featureMtx(10,:))-min(featureMtx(9,:)));

%% 3.1.4 BELOW PART TO FIND INTERSECTION FEATURES;
disMtx = ada_getPointDistance(totalPointMtx);
interSect = ada_findIntersection( disMtx, totalPointMtx);
if interSect(1,1) ==0;
    totFeatMtx(8,1) = 0; % intersect number;
    totFeatMtx(9,1) = 0; % min value between each intersect
    totFeatMtx(10,1) = 0; % max value between each intersect
    totFeatMtx(11,1) = 0; % min value between intersect to end
    totFeatMtx(12,1) = 0; % max value between intersect to end;
    %     clear interSect;
else
    totFeatMtx(8,1) = size(interSect,1); % intersect number;
    interSectDist = ada_getPointDistance(interSect);
    totFeatMtx(9,1) = max(max(interSectDist)); % min value between each intersect
    totFeatMtx(10,1) = min(min(interSectDist)); % max value between each intersect
    interDis2F = [bsxfun(@minus, interSect,  currentStroke(1,1:2)); bsxfun(@minus, interSect,  currentStroke(end,1:2))];
    totFeatMtx(11,1) = max(sqrt(sum(interDis2F.^2 , 2))); % min value between intersect to end
    totFeatMtx(12,1) = min(sqrt(sum(interDis2F.^2 , 2))); % max value between intersect to end;
    %     clear interSectDist interDis2F;
end;

%% keep going on adding features
totFeatMtx(13,1) = norm(totalPointMtx(1,1:2) - totalPointMtx(end,1:2))/(max(featureMtx(10,:))-min(featureMtx(9,:)));
totFeatMtx(14,1) = sum(featureMtx(17,:));
totFeatMtx(15,1) = sum(featureMtx(18,:));
totFeatMtx(16,1) = sum(featureMtx(19,:));
totFeatMtx(17,1) = sum(featureMtx(20,:));
totFeatMtx(18,1) = sum(featureMtx(21,:));
totFeatMtx(19,1) = sum(featureMtx(22,:));
totFeatMtx(20,1) = sum(featureMtx(23,:));
totFeatMtx(21,1) = sum(featureMtx(24,:));
totFeatMtx(22,1) = sum(featureMtx(25,:));
totFeatMtx(23,1) = sum(featureMtx(26,:));    totFeatMtx(24,1) = max(featureMtx(27,:));
totFeatMtx(25,1) = (featureMtx(28,:)*pointNum)/sum(pointNum);
totFeatMtx(26,1) = sum(featureMtx(29,:));
totFeatMtx(27,1) = sum(featureMtx(30,:));

%% 3.1.12 SIDE RATIOS
xMax = max(totalPointMtx(:,1)); xMin = min(totalPointMtx(:,1));
yMax = max(totalPointMtx(:,2)); yMin = min(totalPointMtx(:,2));
totFeatMtx(28,1) = (totalPointMtx(1,1) - xMin)/(xMax - xMin);
totFeatMtx(29,1) = (totalPointMtx(end,1) - xMin)/(xMax - xMin);

%% 3.1.13 TOP AND BUTTOM RATIO
totFeatMtx(30,1) = (totalPointMtx(1,2) - yMin)/(yMax - yMin);
totFeatMtx(31,1) = (totalPointMtx(end,2) - yMin)/(yMax - yMin);

%% keep adding features
totFeatMtx(32,1) = (featureMtx(35,1));
totFeatMtx(33,1) = (featureMtx(36,end));
totFeatMtx(34,1) = (featureMtx(37,end));
totFeatMtx(35:36,1) = sum(featureMtx(38:39,:),2);
totFeatMtx(37,1) = (featureMtx(40,1));
totFeatMtx(38,1) = (featureMtx(41,end));
totFeatMtx(39,1) = (featureMtx(42,end));
totFeatMtx(40:41,1) = sum(featureMtx(43:44,:),2);

%% 3.1.5 HISTOGRAM
% this feature will be taken with multiple stroke;
area1 = totalPointMtx( totalPointMtx(:,1)<(xMin+(xMax - xMin)/3), :);
area11 = area1(area1(:,2)<yMin+(yMax - yMin)/3,:);
area112 = area1(area1(:,2)<yMin +(yMax - yMin)*2/3,:);
pntNum(3,1) = size(area11,1);
pntNum(2,1) = size(area112,1)- pntNum(3,1); 
pntNum(1,1) = size(area1,1) - pntNum(3,1) - pntNum(2,1);

area21 = totalPointMtx( totalPointMtx(:,1)<(xMin+(xMax - xMin)*2/3), :);
area211 = area21(area21(:,2)<yMin+(yMax - yMin)/3,:);
area2112 = area21(area21(:,2)<yMin +(yMax - yMin)*2/3,:);
pntNum(3,2) = size(area211,1) - pntNum(3,1); pntNum(2,2) = size(area2112,1) - pntNum(2,1) - pntNum(3,2) - pntNum(3,1);
pntNum(1,2) = size(area21,1) - sum(pntNum(:,1)) - sum(pntNum(:,2));

area3211 = totalPointMtx(totalPointMtx(:,2)<(yMin+(yMax - yMin)*1/3),:);
area32112 = totalPointMtx(totalPointMtx(:,2)<(yMin+(yMax - yMin)*2/3),:);
pntNum(3,3) = size(area3211,1) - sum(pntNum(3,:)); pntNum(2,3) = size(area32112, 1) - sum(sum(pntNum(2:3,:)));
pntNum(1,3) = size(totalPointMtx,1) - sum(sum(pntNum));
totFeatMtx(42:50,1) = (pntNum(1:end)/size(totalPointMtx,1)).';

%% FIT LINE FEATURE;
% totDomPoints(:,3) = 0;
coe = polyfit(totalPointMtx(:,1) , totalPointMtx(:,2) , 1);
pStt = [0 , coe(2) ]; pEnd = [-coe(2) / coe(1) , 0 ];
dis = 0;

for runner = 1 : size(totDomPoints,1);
    dis = dis + abs(det([pStt-pEnd ; totDomPoints(runner,:)-pEnd]))/norm(pStt-pEnd);
end;
totFeatMtx(51,1) = dis/(yMax - yMin);

%% DEFINE FEATURE NAME CELL;

%{
featureName(1:6) = {'stroke number' ; 'cusp number'; 'max between cusp distance';...
    'min between cusp distance' ; 'max cusp to end distance' ; 'min cusp to end distance' };
featureName{7} = 'length ratio'; featureName{8} = 'intersect number'; 
featureName{9} = 'max intersect distantce between e/o' ;
featureName{10} = 'min intersec dis between e/o'; featureName{11} = 'max intersec dis to end' ;
featureName{12} = 'min intersect dis to end';
featureName{13} = 'first-last distance' ;featureName{14} = 'stroke length';
featureName{15} = 'Stroke Area';
featureName{16} = 'Angle Histograme 135'; featureName{17} = 'Angle Histograme 90';
featureName{18} = 'Angle Histograme 45';featureName{19} = 'Angle Histograme positive';
featureName{20} = 'Angle Histograme negtive'; featureName{21} = 'Angle Histograme -45';
featureName{22} = 'Angle Histograme -90' ;featureName{23} = 'Angle Histograme -135';
featureName{24} = 'dominant point max angle';featureName{25} = 'dominant point diff angle';
featureName{26} = 'dominant straight line ratio';featureName{27} = 'dominant line zero crossing times';
featureName{28} = 'side ratio start'; featureName{29} = 'side ratio end';
featureName{30} = 'Top Ratio' ; featureName{31} = 'Buttom Ratio';featureName{32} = 'x start direction';
featureName{33} = 'x ending direction'; featureName{34} = 'x ending length ratio';
featureName{35} = 'x Max Number' ; featureName{36} = 'x Min Number';
featureName(37:41) = {'y start direction'; 'y ending direction'; 'y ending length ratio'; 'y max num'; 'y min num';};
featureName{42} = 'point Histograme'; featureName{51} = 'fit Line FEature';
%}
% totFeatMtx
%     figure
%     hold on;
% plot(totalPointMtx(:,1) , totalPointMtx(:,2),'r.');
% plot(totDomPoints(:,1) , totDomPoints(:,2) , 'k*');
%     if exist('interSect')==1;
%         plot(interSect(:,1) , interSect(:,2) , 'bo');
%     end;
%{
final(1:12,1) = totFeatMtx(1:12,:);
final(13:21,1) = totFeatMtx(42:50,1);
final(22,1) = totFeatMtx(19,1) + totFeatMtx(23,1);
final(23,1) = totFeatMtx(18,1) + totFeatMtx(22,1);
final(24,1) = totFeatMtx(17,1) + totFeatMtx(21,1);
final(25,1) = totFeatMtx(16,1) + totFeatMtx(20,1);
final(26:27,1) = totFeatMtx(13:14,1);
final(28,1) = totFeatMtx(51,1);
final(29:32,1) = totFeatMtx(24:27,1);
final(33,1) = totFeatMtx(15,1);
final(34:37,1) = totFeatMtx(28:31,1);
% 
final(38:47,1) = totFeatMtx(32:41,1);

totFeatMtx = final;
%}