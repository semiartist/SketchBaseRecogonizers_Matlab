function IBR_add2Template(Graph, tempName)

% THIS FUNCTION IS TO CONSTRUCT THE TEMPLATE 3D MATRIX USED IN THIS
% PROGRAM
%

% % LOAD TEMPLATES
load('IBR_graphTemplate');
load('IBR_polarTemplate');
load('IBR_tempMid')
load('IBR_nameCell');

% SAVE THE NORMAL DOT TEMPLATE;
if exist('graphTemplate' )
    currentInd = size(graphTemplate,3) + 1;
else currentInd =1;
end;
long = size(Graph,1);
% if num ==0;
%     num = 10;
% end;
graphTemplate(1:long,:,currentInd) = Graph;
save('IBR_graphTemplate' , 'graphTemplate');


% SAVE THE POLAR GRAPH TEMPLATE
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

polarTemplate(1:long,:,currentInd)= polarGraph;
save('IBR_polarTemplate' , 'polarTemplate')

% SAVE THE POLAR MEDIATE;
% mideant = sum(polarGraph(:,2))/long;
tempMid(currentInd,1) = currentInd;
tempMid(currentInd,2) = min (polarGraph(:,2));
tempMid(currentInd,3) = max (polarGraph(:,2));
save('IBR_tempMid' , 'tempMid');

% SAVE THE NAME TYPE;
nameCell{currentInd} = tempName;
save('IBR_nameCell' , 'nameCell');

