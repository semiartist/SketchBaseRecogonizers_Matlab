function [finalvalue , rejection] = NG_Rejection(tryvalue, possibility , deviation)

%
% THIS FUNCTION IS TO DO THE REJECTION OF THE RESULT
%
%
%
%
%
%
%
%

% % DEFINE THE TRYVALUE FIRST;
finalweight = sortrows(tryvalue,1);
finalvalue = finalweight(end,2);
reject = zeros(10,3);
reject(:,1) =1:10;
reject(end,1) = 0;

key = 0.5 * 13^2;


% % DEFINE  THE REJECT FOR POSSIBILITY;
for runner = 1:10;
    if possibility(runner,1) <0.95;
        reject(runner,2) = 1;
    end;
    if deviation(runner,1) >=key;
        reject(runner,3) = 1;
    end;
end;

rejection(:,1) = reject(:,1);
rejection(:,2) = reject(:,2) .* reject(:,3);

rejection(rejection(:,2) ==0,:) = [];
