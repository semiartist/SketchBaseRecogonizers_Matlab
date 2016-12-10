function Output = SS_RemoveZero(Input)

% THIS FUNCTION IS TO REMOVE THE ZEROS IN THE 2-D Matrix or 1-D VECTOR;

if size(Input,3) ~=1;
    error('THIS FUNCTION CAN ONLY PROCESS UP TO 2-D MATRIX')
else
    [rownum, colnum] = size(Input);
    Output = Input;
    for rn = rownum :-1:1;
        if Input(rn,1) ==0;
            for cn = 2:colnum;
                if Input(rn,colnum)~=0;
                    error('point sequence number should not be zero;')
                end;
            end;
            Output(rn,:) = [];
        end;
    end;    
end;

% END OF FUNCTION;
% fei chen - 2/18/16;