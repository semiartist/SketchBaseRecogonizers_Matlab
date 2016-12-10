function currenttrain = NG_RemoveZero(currenttrain)
%
%
%
%
%
%

[row, col] = size(currenttrain);

if all(currenttrain(1,:) ==0);
    currenttrain =[];
else
    for runner = row:-1:1;
        if all(currenttrain(runner,:) ==0);
            currenttrain(runner,:)=[];
        end;
    end;
end;