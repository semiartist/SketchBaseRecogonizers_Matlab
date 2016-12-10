function tbpLineFnl = SS_AccurateSplit (tbpSplit , tbprocessfn )





% This function use curvature sign change to determin the fail or not;

% determin which points has a curvature fail;
location = find(tbpSplit(:,9) >0 );
location(end+1) = size(tbpSplit, 1);
tbpSplit(location, 7) = 5;


segnum = size(location,1);
if isempty(location);
    StartEnd = [1 , size(tbpSplit,1)];
else
    currenthandler = 0;
    for fn = 1:segnum;
        StartEnd(fn,1) = currenthandler+1;
        currenthandler = location(fn,1);
        StartEnd(fn, 2) = currenthandler-1;
    end;
end;

tbpLineFnl = SS_LinePostProcess (StartEnd, tbpSplit);

preerr = tbprocessfn(4);
curerr = max(tbpLineFnl(:,4));
if curerr >= preerr;
    tbpLineFnl = [1 , size(tbpSplit,1)];
end;