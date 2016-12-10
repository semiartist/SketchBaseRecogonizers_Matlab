function potential = ada_getResult2(featureVector)

% dbstop if error;

load('ada_strongClassifier');
load('ada_classifierMtx' );
load('ada_alphaMtx' );
T = 5;
[featureNum , classNum] = size(classifierMtx);
resultTable = zeros(1,classNum);

for firstSymbol = 1:classNum-1;
    for secondSymbol = firstSymbol+1 :classNum;
        currentClassifier = classifierMtx(:, [firstSymbol, secondSymbol]);
        resultValue = 0;
        for runner = 1:featureNum*T;
            featureInd = mod(runner -1, featureNum) +1;
            resultValue = resultValue + alphaMtx(featureInd,secondSymbol, firstSymbol)*...
                ada_weakClassifier(currentClassifier(featureInd,:) , featureVector(featureInd,1));
        end;
        finalScore(firstSymbol, secondSymbol) = resultValue;
        if sign(resultValue) ==1;
            resultTable(1,firstSymbol) = resultTable(1,firstSymbol)+1;
        else
            resultTable(1,secondSymbol) = resultTable(1,secondSymbol) +1;
        end;
    end;
end;

potential = find(resultTable == max(resultTable))

if size(potential,2) >1;
    for firstNum = 1:size(potential,2)-1;
        firstIndex = potential(1,firstNum);
        for secondNum = firstNum+1:size(potential,2);
            secondIndex = potential(1,secondNum)
            if finalScore(firstIndex,secondIndex)>=0
                tempResult = firstIndex;
            else
                tempResult = secondIndex;
            end
        end
    end
    potential = tempResult;
end;


        