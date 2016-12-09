function result = OR_Compare_Graph(finalGraph)
%
% THIS FUNCTION IS USED TO ROTATE THE POINTS INTO 0 DEGREE POSITION
%
%
%
%
%
%
%
%

% % TEST AREA
% load('finalGraph');

% end test area;

load ('OR_Sample');
% load('OR_Sample_Name');

possibility = size(OR_Sample,4);
stamper = size(OR_Sample,3);
pntNum = size(OR_Sample,1);

finalValue = zeros(possibility, 2);

% COMPUTE TO EACH SAMPLE TO GET VALUE;
for runner = 1: possibility;
    totalValue = 0;
    for jumper = 1:stamper;
        currentSample = OR_Sample(:,:,jumper, runner);
        missMatch = finalGraph - currentSample;
        currentValue = 0;
        for pnt = 1:pntNum;
            q = norm(missMatch(pnt,:));
            currentValue = currentValue+q;
        end;
        if jumper ==1;
            finalValue(runner, 2) = currentValue;
        elseif finalValue(runner, 2) > currentValue;
            finalValue(runner, 2) = currentValue;
        end;
        totalValue = totalValue + currentValue;
    end;
    finalValue(runner,1) = totalValue;
end;

% DEFINE THE POSSIBILITY;
% finalValue(:,1) = total distance;
% finalValue(:,2) = min distance;

% minValue = min(finalValue);
% minTotal = find(finalValue(:,1) == minValue(1));
% minMin = find(finalValue(:,2) == minValue(2));
% 
% weightTotal = sum(finalValue);
for runner = 1:possibility;
%     finalValue(runner,3) = round((1-(finalValue(runner,1)/weightTotal(1)))*100);
%     finalValue(runner, 4) = round((1- (finalValue(runner,2) / weightTotal(2)))*100);
    officialValue = 1 - finalValue(runner,2)/(64*0.5*sqrt(0.5^2+0.5^2));
    finalValue(runner,3) = round(officialValue * 100);
end;

% if minTotal == minMin;
%     finalShapeIndex = minTotal;
% else
%     totalPct = finalValue(minTotal,3);
%     minPct = finalValue(minMin,4);
%     if totalPct<=minPct;
%         finalShapeNum = minTotal;
%     else %totalPct>minPct;
%         finalShapeNum = minMin;
%     end
finalShapeIndex = find(finalValue(:,3) == max(finalValue(:,3)));
% end;
finalShapePct = finalValue(finalShapeIndex,3);
% finalShapeName = OR_Sample_Name(finalShapeNum);
result = [finalShapeIndex , finalShapePct];






