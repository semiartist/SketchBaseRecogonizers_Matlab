function result = IBR_noRotateMatch(Graph, resolution)

%
% THIS FUNCTION WILL MATCH THE GRAPH WITH SEVERAL DIFFERENT KINDS OF
% TEMPLATES, TO DETERMIN WHICH TEMPLATE FITS THE GRAPH MOST;
%
%
% Input: Graph from last step;
%
% Output:
% result = index of the template;
% Fei Chen 4/2/2016
%
%

% % TEST AREA % %

% clear all ; close all ; clc;
% dbstop if error;
% load('IBR_Graph');
% dbstop if error;
% resolution = 48;

% end of test area;

% LOAD THE TEMPLATE DATA
load('IBR_graphTemplate');

%CALCULATE PREEXIST INFORMATION;
pntNumGraph = size(Graph, 1);
numTemp = size(graphTemplate,3);  %% MODIFIED FOR ROTATED GRAPH
if numTemp > 11;
    numTemp = 11;
end;
betty = sqrt(resolution*resolution*2)/15;   % coe for calculateing tanimoto

for runner = 1:numTemp;    %% MODIFIED FOR ROATED GRAPH
    % The loop is defined for each templates
    currentTemp = IBR_removeZero(graphTemplate(:,:,runner));
    pntNumTemp = size(currentTemp,1);
    % clear hausdorff;
    for jumper = 1:pntNumGraph;
        % THIS LOOP IS DEFINED FOR EACH POINTS IN GRAPH
        %graph2D(Graph(jumper,1)+1,Graph(jumper,2)+1) = 1;
        for swimmer = 1:pntNumTemp;
            % THIS LOOP IS DEFINED FOR EACH POINTS IN CURRENT TEMPLATE
            % THESE 2 LOOPS JUST TO CALCULATE THE DISTANCE BETWEEN EACH
            % POINTS IN TEMPLATE AND NEW GRAPH
            hausdorff(jumper, swimmer) = norm(Graph(jumper,:) - currentTemp(swimmer,:));
            %if jumper ==1;
            %temp2D(currentTemp(swimmer,1)+1,currentTemp(swimmer,2)+1)=1;
            %end;
        end;
    end;
    
    % AFTER FINISH EACH LOOP, CALCULATE EACH COEFFICIENT
    
    % CALCUALATE FOR THE HAUSDORFF AND MODIFIED HAUS
    minDisGraph = min(hausdorff.');
    minDisTemp = min(hausdorff);
    Haus(runner,1) = max(max(minDisGraph),max(minDisTemp)); %% REPLATED WITH
    % BOTTON FUNTION AS ROATED GRAPH;
    % Haus =  max(max(minDisGraph),max(minDisTemp)); %%
    %     hTG(1 , runner) = max(minDisTemp);
    modiHaus(runner,1) =max( sum(minDisGraph)/pntNumGraph,sum(minDisTemp)/pntNumTemp);
    % % REPLACE WITH BELOW FOR ROTATED TEMPLATE;
    % modiHaus = max( sum(minDisGraph)/pntNumGraph,sum(minDisTemp)/pntNumTemp);
    % %%
    %     modTG(1, runner) = sum(minDisTemp)/pntTemp;
    
    % CALCUALATE FOR THE TANIMOTO COEFFIECIENT;
    
    %realBlack = size(find(hausdorff ==0),1);
    blackGraph = size(find(minDisGraph<=betty),2);
    blackTemp =  size(find(minDisTemp<=betty),2);
    whiteTemp = resolution^2 - pntNumTemp - pntNumGraph + blackTemp;
    whiteGraph = resolution^2 - pntNumTemp - pntNumGraph + blackGraph;
    black = blackGraph + blackTemp; white = whiteGraph + whiteTemp;
    taniBlack = black/(pntNumTemp + pntNumGraph - black+0.001);
    taniWhite = white/(pntNumTemp + pntNumGraph - 2*black + white);
    alpha = 0.75-0.25*(pntNumTemp + pntNumGraph)/(2*resolution^2);
    tanimoto(runner,1) = alpha*taniBlack + (1-alpha)*taniWhite; 
    % % REPLACED WITH BELOW FUNCTION AS ROTATE THE GRAPH;
    % tanimoto = alpha*taniBlack + (1-alpha)*taniWhite;
    
    % CALCULATE FOR THE YULE COEFFICIENT
    yule(runner,1) = (black*white-(pntNumGraph - blackGraph)*(pntNumTemp - blackTemp)) /...
        (black*white + (pntNumGraph - blackGraph)*(pntNumTemp - blackTemp));
    % % REPLATED WITH BELOW FUNCTION AS ROTATE GRAPH METHOD;
    %yule =(black*white-(pntNumGraph - blackGraph)*(pntNumTemp - blackTemp)) /...
    %    (black*white + (pntNumGraph - blackGraph)*(pntNumTemp - blackTemp));
    
    % BELOW RESULT IS FOR ROTATION OUTPUT
    % %result = [Haus ; modiHaus ; tanimoto ; yule];
    
end; %% MODIFIED FOR ROTATED GRAPH

% % CANCEL BELOW LINES FOR ROTATE GRAPH METHOD, COMPARE THE WEIGHT IN THE
% MAINMATCHING FUNCTION

% TRANSFORM THE 4 COEFFICNET TO RIGHT ORIENTATION;
% for Haus
minHaus = min(Haus); maxHaus= max(Haus);
finalHaus = (Haus-minHaus)/(maxHaus - minHaus );
% for modified Haus
minModiHaus = min(modiHaus) ; maxModiHaus=max(modiHaus);
finalModiHaus = (modiHaus - minModiHaus)/(maxModiHaus - minModiHaus);
% for tanimoto
minTani = min(tanimoto) ; maxTani = max(tanimoto);
finalTani = (tanimoto - minTani)/(maxTani - minTani);
%for Yule
minYule = min(yule) ; maxYule = max(yule);
finalYule = (yule - minYule)/(maxYule - minYule);

weight = -finalHaus -finalModiHaus + finalTani + finalYule;
[~ , result] = max(weight);
% % end of function
% Fei Chen, 4/3/2016