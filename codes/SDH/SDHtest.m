function B = SDHtest(X, model, type)
%X: each row is a sample
%B: each column is a (compact) binary code

if(nargin<3)
    type = 'uint8';
end

if(strcmp(model.opts.kernel,'RBF'))
    gamma2 = 1/2/(model.sigma^2);
    D2 = Euclid2(X,model.anchor,'row',0);
    Phi = [exp(-D2*gamma2),ones(size(D2,1),1)];
elseif(strcmp(model.opts.kernel,'linear'))
    Phi = [X,ones(size(X,1),1)];
else
    error('bad type');
end

B = (Phi*model.W>0)';
if(strcmp(type,'uint8'))
    B = compactbit(B')';
end

end