function SS_PlotMergeFn(Lines, Arcs);




hold on;
% for lines;
linenum = size(Lines,3);
if size(Lines ,1)~=1 && Lines(1,1)~=0;
    for ln = 1:linenum;
        currentline = SS_RemoveZero(Lines(:,:,ln));
        k = currentline(1,3);
        b = currentline(1,4);
        
        if abs(atand(k)) > 70;
            ploty = currentline(:,2);
            plotx = ( ploty - b)/k;
        else
            plotx = currentline(:,1);
            ploty = k*plotx + b;
        end;
        plot(plotx, ploty, 'g' , 'LineWidth' , 3);
        hold on;
    end;
end;

% for arcs;
arcnum = size(Arcs,3);
if size(Arcs,1)~=1 && Arcs(1,1)~=0;
    for an = 1: arcnum ;
        currentarc = SS_RemoveZero(Arcs(:,:, an));
        deg1 = currentarc(1,6);
        deg2 = currentarc(1,7);
        XC = currentarc(1,3);
        YC = currentarc(1,4);
        R = currentarc(1,5);
        deg = deg1:0.1:deg2;
        plotx = R*cosd(deg) + XC;
        ploty = R*sind(deg) + YC;
        
        plot(plotx, ploty, 'g' , 'LineWidth' , 3);
        hold on;
    end;
end