function [h] = ada_weak(x,mu1,mu2)
% weak hypothesis
if abs(x-mu1)<=abs(x-mu2)
    h=1;
else
    h=-1;
end
end

