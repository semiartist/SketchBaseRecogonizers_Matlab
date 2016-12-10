function ada_trainingAdaBoost();

load('ada_trainFeatureMtxCell');

answer = inputdlg('prompt','dlg_title')
if isempty(str2num(cell2mat(answer)));
    T = 100;
else
    T = str2num(cell2mat(answer));
end;

% PREDEFINE SOME KEY PARAMETER;
% T = 10;       %ITERATION PARAMETER, CHOOSE FROM 1000; 800;500;100;50;10;
J = size(trainFeatureMtxCell{1},1);   % feature number;
symbolNum = size(trainFeatureMtxCell,1);

bar = waitbar(0 , 'Training in process, please wait...');
% THE MAIN TRAINING PROCESS;
for firstSymbol = 1:symbolNum-1;
    waitbar(firstSymbol/symbolNum ,bar, 'Training in process, please wait...');
    symbolMtx1 = trainFeatureMtxCell{firstSymbol};
    firstM = size(symbolMtx1,2);  % is the sample number for current set;
    %     symbolSS1 = size(symbolMtx1,2);
    %     symbolMtx1(:,:,2) = 1/m;
    for secondSymbol = firstSymbol + 1: symbolNum
        symbolMtx2 = trainFeatureMtxCell{secondSymbol};
        secondM = size(symbolMtx2,2);
        symbolMtx = [symbolMtx1 , symbolMtx2];
        symbolMtx(:,1:firstM,2) = 1;
        symbolMtx(:,firstM+1:firstM+secondM,2) = -1;
        symbolMtx(:,:,3) = 1/(firstM + secondM);
        % first generat classifer;
        if ~exist('classifierMtx') || isempty(classifierMtx(:,firstSymbol));
            classifierMtx(:,firstSymbol) = mean(symbolMtx1,2);
        end
        if ~exist('classifierMtx(:,secondSymbol)')
            classifierMtx(:,secondSymbol) =  mean(symbolMtx2,2);
        end;
        
        % GET CURRENT CLASSIFIER FOR FIRST SYMBOL AND SECOND SYMBOL;
        currentClassifier = [classifierMtx(:,firstSymbol) , classifierMtx(:,secondSymbol)];
        for cycle = 1:T*J;
            featureInd = mod(cycle-1, J)+1;
            % GET THE TOTAL NUMBER OF SAMPLE IN FIRST SYMBLE AND SECOND SYMBOL;
            classificationError = 0;
            clear result;
            for runner = 1: firstM + secondM;
                result(1,runner) = ada_weakClassifier(currentClassifier(featureInd,:) , symbolMtx(featureInd,runner,1));
                if symbolMtx(featureInd, runner, 2) ~= result(1,runner);
                    classificationError = classificationError + symbolMtx(featureInd,runner,3);
                end;
            end;
            if classificationError==0
                alpha = 10;
            elseif classificationError ==1
                alpha = -10;
            else
                alpha = 1/2*log((1 - classificationError)/classificationError);
            end
                
            newWeight = bsxfun(@times, symbolMtx(featureInd, :,3) , exp(-alpha*bsxfun...
                (@times, symbolMtx(featureInd,:,2) , result )));
            newWeight(find(isnan(newWeight))) = 0;
            symbolMtx(featureInd,:,3) = newWeight/sum(newWeight,2);
            % sum(newWeight,2)  % sum(symbolMtx(featureInd,:,3),2)
            alphaMtx(featureInd,secondSymbol,firstSymbol) = alpha;
        end
        disp( [firstSymbol, secondSymbol]);
        strongClassifier{firstSymbol, secondSymbol} = symbolMtx(:,:,[1,3]);
    end
end;
close(bar);
save('ada_strongClassifier' , 'strongClassifier');
save('ada_classifierMtx' , 'classifierMtx');
save('ada_alphaMtx' , 'alphaMtx');
