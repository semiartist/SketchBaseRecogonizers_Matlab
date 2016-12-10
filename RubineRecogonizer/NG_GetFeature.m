function PntFtr = NG_GetFeature(PntMtx)

%
% THIS FUNCTION IS TO CONSTRUCT THE FEATURE MATRIX OF THE STROKE, TO GET A
% PNTFTR MATRIX;
% 
%
%
%
%
%

% % TEST CODE AREA
% clear ; close ; clc;
% load('PntMtx');
% load('PntMtx2');
% PntMtx = PntMtx2;
% format bank;
% plot(PntMtx(:,1) , PntMtx(:,2))

% % % % END OF TEST CODE AREA;

% % GET SOME BASIC NEEDED INFORMATION

pntnum = size(PntMtx,1);
firstpnt = PntMtx(1,1:2);
lastpnt = PntMtx(end,1:2);

xmax =max(PntMtx(:,1));
xmin = min(PntMtx(:,1));
ymax = max(PntMtx(:,2));
ymin = min(PntMtx(:,2));


% % IF TO KEEP GOING OR NOT;
if pntnum <4;
    error('no enough point data!')
end;

PntFtr = zeros(1,13);
% % DETAILED FEATURE CALCULATED PART;

% Feature 1 & 2;
firstangle = NG_GetAngle(PntMtx(1,1:2) , PntMtx(3,1:2));
PntFtr(1,1) = cosd(firstangle);
PntFtr(1,2) = sind(firstangle);

% Feature 3 and 4;
% % THIS FEATURE DEVIDED BY THE XMAX - XMIN;
PntFtr(1,3) = norm([xmax-xmin, ymax - ymin])/(xmax - xmin);
PntFtr(1,4) = NG_GetAngle( [xmin, ymin],[xmax, ymax]);

% Feature 5 and 5B 6, 7;
% % FEATURE 5 ALSO DEVIDED BY XMAX-XMIN;
PntFtr(1,5) = norm([firstpnt - lastpnt])/(xmax - xmin);
PntFtr(1,6) = cosd(NG_GetAngle(firstpnt, lastpnt));
PntFtr(1,7) = sind(NG_GetAngle(firstpnt, lastpnt));

% Initial the Feature 8 and 12;
PntFtr(1,8) = norm(PntMtx(1, 1:2)-PntMtx(2, 1:2));
timediff =  PntMtx(2,3)-PntMtx(1, 3);
PntFtr(1,12) = PntFtr(1,8) / timediff;

% Feature 9:12
% % % THIS IS DIFFERENT WITH THE PAPER, PAPER MENTIOEND PREANGLE -
% POSTANGLE, I USE POSTANGLE - PREANGLE;
for runner = 2:pntnum - 1;
    preangle = NG_GetAngle(PntMtx(runner-1, 1:2) , PntMtx(runner, 1:2));
    postangle = NG_GetAngle(PntMtx(runner, 1:2) , PntMtx(runner+1, 1:2)); 
    anglediff = postangle - preangle;
    
    PntFtr(1,8) = PntFtr(1,8) + norm(PntMtx(runner, 1:2)-PntMtx(runner+1, 1:2));
    PntFtr(1,9) = PntFtr(1,9) + anglediff;
    PntFtr(1,10) = PntFtr(1,10) + abs(anglediff);
    PntFtr(1,11) = PntFtr(1,11) + anglediff^2;
    
    % calculate the time;
    timediff = PntMtx(runner + 1,3)-PntMtx(runner, 3);
    currentspeed = norm(PntMtx(runner, 1:2)-PntMtx(runner+1, 1:2))/timediff;
    if currentspeed > PntFtr(1,12);
        PntFtr(1,12) = currentspeed;
    end;
end;


for runner = 1:13 ;
    if isinf(PntFtr(1,runner));
        PntFtr(1, runner) = 99999;
    end;
end;
    

% at last feature 8 devided by xmax - xmin;
PntFtr(1,8)= PntFtr(1,8)/(xmax - xmin);

PntFtr(1,13) = PntMtx(end,3) - PntMtx(1,3);


% % END OF THE FUNCTIONL
% FEI CHEN, 2/27/16





