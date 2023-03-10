function H = TSH_trans(Y, alpha, K, sup_type)
%apply LSH to transformed labels to generate binary codes
%
%inputs:
% Y: label matrix or similarity matrix
% alpha: a trade-off parameter between the effect of the matched pairs and
%        unmatched pairs
% K: the number of hash bits
% sup_type: supervision type, 'Y' for label matrix or 'S' for affinity matrix
%
%outputs:
% H: 0-1 code, column corresponds sample
%

N = size(Y,2);
Y = sparse(Y);
if(strcmp(sup_type,'Y'))%0-1 label vectors
    ns = estimate_ns(Y);
    nd = N^2-ns;
    alpha = alpha*ns/nd;
    P = randn(K,N);
    B = sign((1+alpha)*(P*Y')*Y-alpha*repmat(sum(P,2),1,N));
elseif(strcmp(sup_type,'S'))%0-1 similarity matrix
    ns = nnz(Y);
    nd = N^2-ns;
    alpha = alpha*ns/nd;
    P = randn(K,N);
    B = sign((1+alpha)*P*Y-alpha*repmat(sum(P,2),1,size(Y,2)));
else
    error('Bad Type');
end
H = double(B>0);

end