function LineFnl = SS_GetSwipeDeg(LineFnl,FnlMtx);

%
% THIS FUNCTION IS TO DEFINE HOW THE CIRCLE IS DREW;
%

% % TEST PART
% load('FnlMtx');
% load('LineFnl')
% % END TEST PART
%

degstt = 0;
degend = 0;

linenum = size(FnlMtx,3);
for ln = 1:linenum;
    tbprocess = LineFnl(:,:,ln);
    tbprocess = SS_RemoveZero(tbprocess);
    fitnum = size(tbprocess,1);
    for fn = 1:fitnum;  % for each fit calculate the right degree and angle;
        if tbprocess(fn,3) == 2;
            
            midpntnum = round((tbprocess(fn, 2) - tbprocess(fn,1))/2)+tbprocess(fn,1);
            midpnt = FnlMtx(midpntnum,1:2,ln);
            if (tbprocess(fn, 2) - tbprocess(fn, 1))>5;
                allcrvmem = FnlMtx( tbprocess(fn,1):tbprocess(fn,2),1 :2 ,ln );
                % Then keep use circular interpolation;
                % GET START POINT LOCATION;
                sttpnt = FnlMtx(tbprocess(fn,1),1:2,ln);
                endpnt = FnlMtx(tbprocess(fn,2),1:2,ln);
                sttxside = sttpnt(1) - tbprocess(fn,5);
                sttyside = sttpnt(2) - tbprocess(fn,6);
                if sttxside >= 0 && sttyside>=0;
                    sttpos = 1;
                elseif sttxside>=0 && sttyside <0;
                    sttpos = 4;
                elseif sttxside <0 && sttyside >=0;
                    sttpos = 2;
                else
                    sttpos = 3;
                end;
                
                % GET START PNT DEG;
                sttk = atand(sttyside / sttxside);
                if sttpos == 2 | sttpos ==3;;
                    sttdeg = sttk + 180;
                elseif sttpos ==4 ;
                    sttdeg = sttk + 360;
                else sttdeg = sttk;
                end;
                
                % Get END PNT information
                endxside = endpnt(1) - tbprocess(fn,5);
                endyside = endpnt(2) - tbprocess(fn,6);
                if endxside >= 0 && endyside>=0;
                    endpos = 1;
                elseif endxside>=0 && endyside <0;
                    endpos = 4;
                elseif endxside <0 && endyside >=0;
                    endpos = 2;
                else
                    endpos = 3;
                end;
                % GET END DEG
                endk = atand(endyside / endxside);
                if endpos == 2 | endpos ==3;;
                    enddeg = endk + 180;
                elseif endpos ==4 ;
                    enddeg = endk + 360;
                else enddeg = endk;
                end;
                % Get centerpnt information
                midxside = midpnt(1) - tbprocess(fn,5);
                midyside = midpnt(2) - tbprocess(fn,6);
                if midxside >= 0 && midyside>=0;
                    midpos = 1;
                elseif midxside>=0 && midyside <0;
                    midpos = 4;
                elseif midxside <0 && midyside >=0;
                    midpos = 2;
                else
                    midpos = 3;
                end;
                
                % % Then define the cases for calculate the match;
                
                % if start and end all at same aixe area;
                if endpos == sttpos;
                    % if the midpnt are also at this portion;
                    % Get another help pnt close to stt pnt;
                    helppnt = allcrvmem(3,:);
                    helpxside = helppnt(1) - tbprocess(fn,5);
                    helpyside = helppnt(2) - tbprocess(fn,6);
                    if helpxside >= 0 && helpyside>=0;
                        helppos = 1;
                    elseif helpxside>=0 && helpyside <0;
                        helppos = 4;
                    elseif helpxside <0 && helpyside >=0;
                        helppos = 2;
                    else
                        helppos = 3;
                    end;
                    helpk = atand(helpyside / helpxside);
                    if helppos == 2 | helppos ==3;;
                        helpdeg = helpk + 180;
                    elseif helppos ==4 ;
                        helpdeg = helpk + 360;
                    else helpdeg = helpk;
                    end;
                    
                    % they all in same quardro
                    if midpos == sttpos;
                        degstt = min(enddeg,sttdeg); % start pnt is the samller angle
                        degend = max(enddeg,sttdeg); % end pnt is the large angle;
                        
                    elseif abs(sttdeg - enddeg) < 5; % the degree mass is samller than 5 deg; use circle interpolation;
                        degstt = 0; degend = 360;
                    elseif helppos == sttpos; % the help pnt is in the same quadra;
                        if helpdeg > sttdeg ;
                            % ccw direction;
                            degstt = sttdeg; degend = enddeg + 360;
                        else degstt = enddeg ; degend = sttdeg + 360;
                        end;
                    elseif helppos - sttpos == 1 | helppos - sttpos == -3;
                        % the help pnt is not in the same quadra; but in the ccw
                        % direction;
                        degstt = sttdeg ; degend = enddeg +360;
                    elseif helppos - sttpos == -1 | helppos - sttpos == 3;
                        % in the cw direction
                        degstt = enddeg ; degend = sttdeg + 360;
                    end;
                elseif abs(sttpos - endpos) == 1; % the start pnt and the end pnt is not in a same qudra;
                    if midpos == sttpos | midpos ==endpos;
                        degstt = min(enddeg, sttdeg); degend = max(enddeg, sttdeg);
                    else
                        degstt = max(enddeg, sttdeg); degend = min(enddeg, sttdeg) + 360;
                    end;
                elseif abs(sttpos - endpos) ==3; % they are in 1 or 4;
                    if midpos == sttpos | midpos ==endpos;
                        degstt = max(enddeg, sttdeg); degend = min(enddeg, sttdeg)+360;
                    else
                        degstt = min(enddeg, sttdeg); degend = max(enddeg, sttdeg);
                    end;
                    
                elseif sttpos ==1 | sttpos == 3; % consider the 1/3 ; 2/4 case;
                    if midpos ==2 | midpos == 1;
                        degstt = min(enddeg, sttdeg); degend = max(enddeg, sttdeg);
                    else 
                        degstt = max(enddeg, sttdeg) ; degend = min(enddeg, sttdeg)+360;
                    end;
                elseif sttpos == 2 | sttpos ==4;
                    if midpos ==3 | midpos ==4;
                        degstt = min(enddeg, sttdeg); degend = max(enddeg, sttdeg);
                    else
                        degstt = max(enddeg, sttdeg) ; degend = min(enddeg, sttdeg)+360;
                    end;                  
                end;  % % end assign the start and end point;
            else  %%%% to use linear interpolation;
                degstt = 0; degend = 0;
            end;
            if degend - degstt > 340;
                degstt = 0;
                degend = 360;
            end;
            LineFnl(fn,8:9,ln) = [degstt, degend];
        end;
    end;
end;
% LineFnl
