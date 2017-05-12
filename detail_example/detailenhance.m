function [ res ] = detailenhance( L, L0, L1, weight0, weight1 )
detail0 = L-L0;
detail0 = sigmoid(detail0,weight0);
detail1 = L0-L1;
detail1 = sigmoid(detail1,weight1);
base = L1;
res = base + detail1 + detail0;
res = sigmoid(res,1);
end

function y = sigmoid(x, a)
% DESCR:
% Applies a sigmoid function on the data x in [0-1] range. Then rescales
% the result so 0.5 will be mapped to itself.

% Apply Sigmoid
y = 1./(1+exp(-a*x)) - 0.5;

% Re-scale
y05 = 1./(1+exp(-a*0.5)) - 0.5;
y = y*(0.5/y05);

end

