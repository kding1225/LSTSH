function [H,R] = TSH_label(Y, K)
%apply LSH on labels to generate binary codes

%inputs:
% Y: label matrix, each column is a label vector
% K: the number of hash bits
%
%outputs:
% H: 0-1 coding matrix
% R: random matrix

if(isvector(Y))
    Y = sparse(Y,1:length(Y),1);
end

R = randn(K,size(Y,1));
H = R*Y>0;

end