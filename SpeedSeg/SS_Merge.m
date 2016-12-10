function NewMtx = SS_Merge(Old, New , num);
%
% THIS FUNCTION IS TO MERGE 2 DIFFERENT SIZE MATRIX TO A UNISIZED MATRIX;
% DEFAULT MERGE DIRECTION:
% 1-D: [OLD ; NEW];
% 2-D: [OLD : NEW];
% 3-D: NEWMTX(:,:,n) = OLD; NEWMTX(:,:,n+1) = NEW;
%
% INPUT:
% Old = Previous Matrix You Have;
% New = New Data You Want to Add to Old Matrix;
% num = The dimension you want to have after merge;
%
% OUTPUT
% NewMtx = The Combined Matrix;


% Get Some Basic Information;
olddim1 = size(Old,1); olddim2 = size(Old,2) ; olddim3 = size(Old,3);
newdim1 = size(New,1); newdim2 = size(New,2) ; newdim3 = size(New,3);
colnum = max(olddim1,newdim1);
rownum = max(olddim2, newdim2);

% MAIN FUNCTION BODY;
% dimension you want;
if isempty(find(Old~=0));
    NewMtx = New;
else
    if num ==1;
        NewOld = Old(:);
        NewNew = New(:);
        NewMtx = [NewOld ; NewNew];
    elseif num ==2;
        if olddim3~=1 | newdim3~=1;
            error('Can not merge 3-D Matrix to 2-D Matrix!');
        end;
        
        tempold = zeros(colnum,olddim2);
        tempold(1:olddim1, 1:olddim2) = Old;
        
        tempnew = zeros(colnum, newdim2);
        tempnew(1:newdim1, 1:newdim2) = New;
        
        NewMtx = [tempold , tempnew];
    elseif num ==3;
        tempold = zeros(colnum, rownum, olddim3);
        tempnew = zeros(colnum, rownum, newdim3);
        
        tempold(1:olddim1, 1:olddim2, 1:olddim3) = Old;
        tempnew(1:newdim1, 1:newdim2, 1:newdim3) = New;
        
        NewMtx(:,:,1:olddim3) = tempold;
        NewMtx(:,:,olddim3+1:olddim3+newdim3) = tempnew;
        
    else
        error('cannot operate matrix dimension more than 3!')
        
    end;
end;


% END of the FUNCTION
% FEI CHEN 2/16/16