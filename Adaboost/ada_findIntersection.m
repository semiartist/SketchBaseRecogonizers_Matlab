function interSec = ada_findIntersection(disMtx, currentStroke)

% % TEST AREA
% currentStroke = totalPointMtx;
%  end of test

minDis = sort(disMtx);
minDis = minDis(1:5,:);
[lia , loc] = ismember( disMtx,minDis);
index = find(loc);
firstPnt = ceil(index./size(currentStroke,1));
secondPnt = mod(index, size(currentStroke,1));
secondPnt(secondPnt ==0 ) = firstPnt(secondPnt ==0);
spctIndex =unique( firstPnt(abs(firstPnt - secondPnt)>6));
temp = diff([-2;spctIndex]);
spctStt = find(temp>1);
spctEnd = spctStt - 1;
spctEnd = [spctEnd(2:end,:);size(temp,1)];
spctInd =  find((spctEnd - spctStt)>=2);
suspect = [spctIndex(spctStt(spctInd)) , spctIndex(spctEnd(spctInd))];

if size(suspect,1)>1;
    for line1 = 1:size(suspect,1);
        firstPoint = min([currentStroke(suspect(line1,1),1:2);currentStroke(suspect(line1,2),1:2)]);
        secondPoint = max([currentStroke(suspect(line1,1),1:2);currentStroke(suspect(line1,2),1:2)]);
        boundry = sum(secondPoint - firstPoint);
        
        for line2 = line1+1:size(suspect,1);
            p1 = currentStroke(suspect(line1,1),1:2); p2 = currentStroke(suspect(line1,2),1:2);
            p3 = currentStroke(suspect(line2,1),1:2); p4 = currentStroke(suspect(line2,2),1:2);
            mid1 = abs(p1+p2)/2; mid2 = abs(p3+p4)/2; midP = abs(mid1 + mid2)/2;
            if ((p3(2) - p1(2))/(p2(2) - p1(2)) - (p3(1) - p1(1))/(p2(1) - p1(1)))*...
                    ((p4(2) - p1(2))/(p2(2) - p1(2)) - (p4(1) - p1(1))/(p2(1) - p1(1)))<0 &&...
                    ((p1(2) - p4(2))/(p3(2) - p4(2)) - (p1(1) - p4(1))/(p3(1) - p4(1)))*...
                    ((p2(2) - p4(2))/(p3(2) - p4(2)) - (p2(1) - p4(1))/(p3(1) - p4(1)))<0;
                if ~exist('interSec')
                    interSec = midP;
                else
                    interSec = [interSec ;mid2];
                end;
            end;
            %{
            mid2 = mean([currentStroke(suspect(line2,1), 1:2);currentStroke(suspect(line2,2), 1:2)]);
            length = norm(firstPoint - mid2) + norm(secondPoint - mid2);
            if length < boundry;
                
                %                 thisLine = currentStroke([suspect(line1,1):suspect(line1,2),suspect(line2,1):suspect(line2,2)].',1:2);
                
                %                 if ~exist('sspctPoint')
                %                     sspctPoint = thisLine;
                %                 else
                %                     sspctPoint = [sspctPoint;thisLine];
                %                 end
            end
            %}
        end
        
    end
end

if ~exist('interSec')
    % %     plot(sspctPoint(:,1) , sspctPoint(:,2) , 'ch', 'LineWidth' , 2);
    % %     plot(interSec(:,1) , interSec(:,2) , 'k*', 'LineWidth' , 6)
    % else
    interSec = zeros(1,2);
end;