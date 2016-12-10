function result = IBR_polarRotation(Graph)

%
% THIS FUNCTION HANDLES THE POLAR ROTATION OF THE GRAPH, TO MATCH THE
% TEMPLATES
%
%
%
%

% % TEST AREA % %
% clear all; close all; clc;
% dbstop if error;
% load('IBR_Graph');

% Graph = template(:,:,8);
% % end test

% PART I % TRANSFER THE GRAPH INTO POLAR COORDINATE
% FIND THE CENTROID

load('IBR_tempMid');
load('IBR_polarTemplate')
% BELOW CODE IS FOR CALCUALTE THE TEMPLATE
% for jumper = 1:size(template,3);
% Graph = template(:,:,jumper);
% Graph = IBR_removeZero(Graph);
% %
for runner = 2:size(Graph,1);
    Graph(runner,3) = norm(Graph(runner,1:2) - Graph(runner-1,1:2));
end;
strokeLength = sum(Graph(:,3));
centroid = Graph(:,1:2).'*Graph(:,3) / strokeLength;
centroid = centroid.';

for runner = 1:size(Graph,1);
    polarGraph(runner,2) = norm(Graph(runner,1:2) - centroid)/strokeLength;
    polarGraph(runner,1) = atan2((Graph(runner,2) - centroid(1,2)) , (Graph(runner,1) - centroid(1,1)));
end;

polarGraphUp = max(polarGraph(:,2)); polarGraphDn = min(polarGraph(:,2));
% %
% polarTemplate(1:size(polarGraph,1),:,jumper) = polarGraph;
% clear polarGraph;
% end
% ABOVE CODE IS FOR CALCULATE TEMPLATE

% PART II % MATCHING THE POLAR GRAPH WITH THE TEMPLATES;
polarGraphL = [polarGraph(:,1) - 2*pi,polarGraph(:,2); polarGraph];
polarGraphL = sortrows(polarGraphL,1);

% CALCULATE MEDIATE;
% for runner = 1:size(polarTemplate,3);
%     currentTemp = polarTemplate(:,:,runner);
%     currentTemp = IBR_removeZero(currentTemp);
%     tempMid(runner,1) = runner;
%     tempMid(runner,2:3) = sum(currentTemp)/size(currentTemp,1);
% end

graphMid = sum(polarGraph)/size(polarGraph,1);
% tempMid(:,4) = tempMid(:,3)*0.8;
% tempMid(:,5) = tempMid(:,3)*1.2;
f = 0;
for runner = 1:size(tempMid,1);
    tempUp = tempMid(runner,3) ; tempDn = tempMid(runner,2);
    if (polarGraphUp - polarGraphDn)/(tempUp - tempDn)>0.7;
        upDn = min(polarGraphUp , tempUp); downUp = max(polarGraphDn, tempDn);
        if (upDn - downUp) / (tempUp - tempDn)>0.5;
            f = f+1;
            storageInd(f,1)= tempMid(runner,1);
        end
    end;
end;

if f==0;
    f = size(tempMid,1);
    
    if f>10;
        f= 10;
    end;
    storageInd = 1:f;
    storageInd = storageInd.';
end;


for runner  = 1:24;
    polarGraphL(:,1) = polarGraphL(:,1) + pi/12;
    currentGraph = polarGraphL;
    currentGraph = currentGraph(abs(currentGraph(:,1))<3.2,:);
    tammy = size(currentGraph,1);
    
    for jumper = 1:f;
        currentTemp = polarTemplate(:,:,storageInd(jumper,1));
        currentTemp = IBR_removeZero(currentTemp);
        chang = size(currentTemp,1);
        clear haus;
        
        for tam = 1:tammy;
            for cha = 1:chang;
                haus(tam, cha) = norm(currentTemp(cha,:) - currentGraph(tam,:));
            end;
        end;
        
        currentA = min(haus);
        weight = currentTemp(:,2).^0.1;
        modiHaus(runner,jumper) = min(haus)*weight/chang;
        
    end;
    
%         if runner <3;
%         figure
%         for runner2 = 1:size(tempMid,1);
%             subplot(3,4,runner2)
%             plot(polarTemplate(:,1,runner2) , polarTemplate(:,2,runner2), 'rs');
%             hold on;
%             plot(currentGraph(:,1) , currentGraph(:,2) , 'k*');
%         end;
%         end
end;
paraHaus=min(min(modiHaus))*1.1;
numInd = storageInd(find(min(modiHaus)<paraHaus).');
finalHaus = modiHaus(:,min(modiHaus) < paraHaus );
for runner = 1:size(finalHaus,2);
    rotationInd(runner,1) = find(finalHaus(:,runner) == min(finalHaus(:,runner)));
end;

rotationInd = rotationInd*pi/12;

result = [numInd,rotationInd];


% END OF PROGRAM
% % Fei Chen, 4/4/2016

