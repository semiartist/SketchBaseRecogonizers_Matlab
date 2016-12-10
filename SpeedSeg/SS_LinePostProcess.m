function LineFnl = SS_LinePostProcess (LineIni, FnlMtx);
%
%
%
% % TEST PART;

% close ; clear ; clc;
% load('FnlMtx');
% load('MarkMtx');
% load('LineIni')
% LineIni = LineFnl;
%

% GET INITIAL VALUES;
linenum = size(FnlMtx,3);

% Set LineFnl
LineFnl = LineIni;

for ln = 1:linenum;
    current = LineIni(:,:,ln);
    current = SS_RemoveZero(current);
    curvenum = size(current,1);

    
    % TO SEE IF THE CURVES COULD BE MREGED OR SPLITED;
    for cn = 1: curvenum ;
        
        % Do linear fitting first;
        xvector = FnlMtx(current(cn,1):current(cn,2) , 1 , ln );
        yvector = FnlMtx(current(cn,1):current(cn,2) , 2 , ln );
        
        pntvector = FnlMtx(current(cn,1):current(cn,2) , 1:2 , ln );
        
        [k,b] = SS_GetCoePoly1(xvector,yvector);
        erryl = sum(abs(yvector -(xvector * k + b)));
        errxl = sum(abs(xvector - ((yvector - b)/k)));
        % use new method to calculate error;
        errlnr =  errxl*(sin(atan(erryl/errxl)))/size(xvector,1);
%         errlnr2 = min(erryl, errxl)/size(xvector,1);
        
        % Then do the circular fitting;
        if length(xvector)>10;
            [XC, YC, R, coe] = SS_GetCoeCircular(xvector, yvector);
            errcir = sqrt(sum( abs((xvector - XC).^2 + (yvector - YC).^2 - R^2) ))/size(xvector,1);
        else 
            errcir = 10000000;
        end
        
        % define the type of fitting;
        if errlnr <= errcir ;
            type = 1;
            err = errlnr*100;
            coe1 = k;
            coe2 = b;
            coe3 = 0;
        else 
            type = 2;
            err = errcir*100;
            coe1 = XC;
            coe2 = YC;
            coe3 = R;
        end;
        
        LineFnl(cn,3:7,ln) = [type,err,coe1,coe2,coe3];
        
%         % TEST PLOT THE INTERPLOLATION;
%         liney = k*xvector +b;
%         linex = xvector;
%         theta = 0:0.01:2*pi;
%         cirx = XC + R*cos(theta);
%         ciry = YC + R* sin(theta);
%         
%         if type ==1;
%             plotx = linex;
%             ploty = liney;
%         elseif type ==2;
%             plotx = cirx;
%             ploty = ciry;
%         end;
%         
%         
% %         plot (linex, liney,'g' ,'LineWidth' , 2)
%         
%         hold on;
% %         plot( cirx, ciry, 'b','LineWidth' , 2)
%         plot(plotx, ploty, 'b' ,'LineWidth' , 2)
        
    end;
end;

for ln = 1:linenum ; 
    LineFnl(1,1,ln) = 1;
end;




