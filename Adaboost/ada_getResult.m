function winner = ada_getResult(featureVector)

load('ada_strongClassifier');
T = 5;
J = 47;
H = zeros(9,10);
for runner = 1:9;
    for jumper = runner+1:10;
        weakClassifier = parameter{runner,jumper}{2};
        alpha = parameter{runner,jumper}{1};
        temp = 0;
        for t = 1:J*T;
            j = mod(t-1,J)+1;
            h = ada_weak(featureVector(j) ,weakClassifier(t,1),weakClassifier(t,2));
            temp = temp + alpha(t)*h;
        end;
        temp = sign(temp);
        H(runner,jumper) = temp;
    end;
end;

score = zeros(10,1);
for hh=1:9
    for j=hh+1:10
        if H(hh,j)==1
            score(hh)=score(hh)+1;
        else
            score(j)=score(j)+1;
        end
    end
end
result=find(score==max(score));
winner=result-1;
tie=numel(result);
tie=numel(result);
if tie>1
    for gg=1:tie-1
        if H(result(gg),result(gg+1))==1;
            winner=result(gg);
        else 
            winner=result(gg+1);
        end
    end
    winner=winner-1;
else
    winner=result-1;
end