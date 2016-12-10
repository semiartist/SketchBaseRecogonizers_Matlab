function SS_PlotFn(FnlMtx, LineFnl)

% THIS FUNCTION IS TO PLOT THE FINAL RESULT INTO THE AXIS
%
%
%
%

linenum = size(FnlMtx,3);
for ln = 1: linenum;
    tbprocess = LineFnl(:,:,ln);
    tbprocess = SS_RemoveZero(tbprocess);
    curvenum = size(tbprocess,1);
    for cn = 1:curvenum ;
        if tbprocess(cn, 3) == 1;
            plotdata = FnlMtx(tbprocess(cn, 1) :tbprocess(cn, 2) , 1:2,ln );
            if abs(atan(tbprocess(cn, 5)))< pi/3 % && abs(atan(tbprocess(cn, 5))) < 1.48;
                plotx = plotdata(:,1);
                ploty = plotx * tbprocess(cn, 5) +tbprocess(cn, 6);
%             elseif abs(atan(tbprocess(cn, 5))) >= 1.48;
%                 plotx = ones(size(plotdata,1) , 1)* mean(plotdata(:,1));
%                 ploty = plotdata(:,2);
%             elseif abs(atan(tbprocess(cn, 5))) <=0.08;
%                 ploty = ones(size(plotdata,1) , 1)* mean(plotdata(:,2));
%                 plotx = plotdata(:,1);
            else
                ploty = plotdata(:,2);
                plotx = (ploty - tbprocess(cn, 6))/tbprocess(cn, 5);
            end;

        elseif tbprocess(cn, 3) ==2;
            deg = tbprocess(cn, 8) : 0.1:tbprocess(cn, 9);
            plotx = tbprocess(cn, 7) * cosd(deg) + tbprocess(cn, 5);
            ploty = tbprocess(cn, 7) * sind(deg) + tbprocess(cn, 6);
        end;
        plot (plotx, ploty, 'b' , 'LineWidth' , 2);
        hold on;
    end;
end;
