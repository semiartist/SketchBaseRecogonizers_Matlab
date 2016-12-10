function NG_MouseMove(hObject, eventdata, handles)
global drawing pntnum PntMtx drawed pntnum2 PntMtx2


if drawing
    C = get(gca,'CurrentPoint');
    if C(1,1)<1 && C(1,1)>0 && C(1,2)<1 && C(1,2)>0
        
        pntnum2 = pntnum2+1;
        PntMtx2(pntnum2,1) = C(1,1);
        PntMtx2(pntnum2,2) = C(1,2);
        %         PntMtx2(pntnum2,3) = toc;
        if pntnum2 >2;
            
            plot(PntMtx2(pntnum2-1:pntnum2,1),PntMtx2(pntnum2-1:pntnum2,2),'k' ,'LineWidth',4);
            
        end;
        hold on
        xlim([0 1]); ylim([0 1]);
        %         set(gca,'XTick',[],'YTick',[])
        box on
    end
    if NG_AddPnt(C, PntMtx);
        pntnum = pntnum+1;
        PntMtx(pntnum,1) = C(1,1);
        PntMtx(pntnum,2) = C(1,2);
        PntMtx(pntnum,3) = toc;
        %         plot(C(1,1),C(1,2),'k*')% ,'MarkerFaceColor','b'
        hold on
        xlim([0 1]); ylim([0 1]);
        set(gca,'XTick',[],'YTick',[])
        box on
        drawed = 1;
    end;
end;


% % END OF FUNCTION
% FEI CHEN 2 /27/16