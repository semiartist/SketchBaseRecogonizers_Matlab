function IBR_graphPlotFunction(Graph, resolution);

%
% This function is to plot the 2D pixel graph into the top-right corner of
% the gcf.
%
%
%

pntNum = size(Graph,1);
width = 0.005*48/resolution;

for point = 1:pntNum;
    x = Graph(point,1);
    y = Graph(point,2);
    xx = x+1; yy = y+1;
    xVector = [x xx xx x]*width + 0.75;
    yVector = [y y yy yy ]*width +0.75;
    fill(xVector, yVector,'k');
    hold on;
end;
