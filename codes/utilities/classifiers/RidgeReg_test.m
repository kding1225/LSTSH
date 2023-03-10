function B = RidgeReg_test(X, model, type)
%compute 0-1 code or compact uint8-type code

%X: each column is a data
%type: 'binary' for 0-1 code and 'uint8' for compact code

%B: 0-1 code or compact uint8-type code

if(nargin<3)
    type = 'uint8';
end

if(strcmp(model.opts.kernel,'RBF'))
    D2 = Euclid2(model.Z,X,'col',0);
    F = [exp(-model.gamma2*D2);ones(1,size(X,2))];
else
    F = [X;ones(1,size(X,2))];
end

if(strcmp(type,'uint8'))
    B = model.V'*F>0;
    B = compactbit(B')';
elseif(strcmp(type,'binary'))
    B = model.V'*F>0;
elseif(strcmp(type,'real'))
    B = model.V'*F;
else
    error('Bad type');
end

end