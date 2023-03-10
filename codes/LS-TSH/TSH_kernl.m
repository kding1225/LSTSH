function H = TSH_kernl(Y, K, opts)
%use kernel hashing to generate binary codes, additive kernel approximation
%is used in this code

%number of pcs
if(isfield(opts,'npcs'))
    npcs = opts.npcs;
else
    if(all(sum(Y,1)<=1))%multi-class
        npcs = size(Y,1);
    else%multi-label
        npcs = 10;
    end
end

% Y = bsxfun(@rdivide, Y, sum(Y)+eps);
Yt = vl_homkermap(Y+1e-9,3,'kernel',opts.ker_type);
[eigvector, ~] = myPCA(Yt', struct('ReducedDim',npcs));
H = randn(K,size(eigvector,2))*eigvector'*Yt>0;

end