function [newMtx] = SS_GetSpeed(InputMtx);

% function information;
% THIS function is created for speedseg augrithm implementation;
% input
% InputMatrix = the PntMtx we get from main program;
% 
% Output:
% SpeedMtx = the matrix contains speed of each points;
%             [1pnt xvalue, 2pnt yvalue, 3pnt time, 
%              4pnt distance, 5pnt speed];
% AverageSpeedMtx

% % TEST PART;
% clc
% load('threeline')
% InputMtx = PntMtx;

% END OF TEST PART;


% get size ;
linenum = size(InputMtx, 3);
maxpntnum = size(InputMtx,1);


% get speed information for each pnt;
% first get distance infomrmation between each secutive pnts;
for ln = 1:linenum;
    for pn = 2:maxpntnum;
        if InputMtx(pn,3,ln)~=0;
            InputMtx(pn,4,ln) = norm(InputMtx(pn,1:2,ln) -InputMtx((pn-1),1:2,ln));
        end;
    end;
end;

% 2nd get the speed information
for ln = 1:linenum;
    % non-0 time entries
    nz = max(find((InputMtx(:,3,ln))~=0));
    % do the speed for the first and last 2;
    % first 2;
    InputMtx(2,5,ln) = sum(InputMtx(2:3,4,ln))/...
        (InputMtx(3,3,ln)-InputMtx(1,3,ln));
    InputMtx(1,5,ln) = 0; 
    %last 2;
    InputMtx(nz-1:nz,5,ln) = sum(InputMtx((nz-1):nz,4,ln))/...
        (InputMtx(nz,3,ln)-InputMtx(nz-2,3,ln));
    
    %the speed of the rest points;
    for pn = 3:(nz-2);
        InputMtx(pn,5,ln) = sum(InputMtx((pn-1):(pn+2),4,ln))/...
            (InputMtx(pn+2,3,ln)-InputMtx(pn-2,3,ln));
    end;
    
end;

newMtx = InputMtx;


% end of the function
% Fei Chen, 2/14/16