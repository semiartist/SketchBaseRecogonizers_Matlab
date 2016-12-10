function result = ada_weakClassifier(thisClassifier, input);

if input <=mean(thisClassifier,2);
    result = 1;
else 
    result = -1;
end;