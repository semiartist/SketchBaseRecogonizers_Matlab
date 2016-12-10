% function [numberMtx] = ada_strokePreProcessing(pointMtx)

% THIS FUNCTION IS TO PREPROCESSING THE STROKES INTO DIFFERENT AREA, TO
% CALCULATE EACH AREA'S MOST POSSIBLE NUMBER;


% % TEST AREA
clear all ; close all ; clc;
load('ada_pointMtx');

% END OF TEST AREA;

[pointNum , ~ , strokeNum] = size(pointMtx);
strokeArea = zeros(2,2,strokeNum);
for runner = 1:strokeNum;
    currentStroke = pointMtx(:,1:2,runner);
    currentStroke(currentStroke(:,1) ==0,:) = [];
    strokeArea(1,:,runner) = max(currentStroke);
    strokeArea(2,:,runner) = min(currentStroke);
    
    % test plot
    %     figure
    plot(currentStroke(:,1) , currentStroke(:,2) , 'k*')
    hold on;
end;
comb = 0;
for firstStroke = 1:strokeNum-1;
    for secondStroke = firstStroke+1:strokeNum;
        comb = comb+1;
        line(comb,1:3) = [firstStroke , secondStroke, 0];
        if ada_oneNumberOrNot(strokeArea(:,:,firstStroke), strokeArea(:,:,secondStroke)) ==0;
            line(comb,3) = 1;
        end
    end
end;

numberMtx(:,:,:,runner) = pointMtx(:,:,runner);
potential = find(line(:,3) ==1);
if ~isempty(potential);
    crossLine = line(potential,1:2);
    if size(corssLine,1)*size(corssLine,2) == size(unique(crossLine),1);
        % DO IT AS REGULAR WAY;
        for runner = strokeNum:-1:1;
            current = find(crossLine(:,2) == runner);
            if ~isempty(current)
                numberMtx(:,:,size(numberMtx(:,:,:,)),crossLine(current,1))
                    
                    
                    
                    
                    
                    
                    