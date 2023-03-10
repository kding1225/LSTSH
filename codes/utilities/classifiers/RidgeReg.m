function model = RidgeReg(X, Y, opts)
%ridge regression
%input:
% X: each column is a data
% Y: each column is a label in [0,1] or [-1,+1] range
% opts:
%  sig_scl: sigma scale factor for Gaussian kernel
%
%output:
% model: resultant model structure

N = size(X,2);
assert(N==size(Y,2));

a = unique(Y(:));
if(length(a)>2)
    error('Y must be binary vector');
end
if(min(a)==0)%convert -1/+1
    Y = 2*Y-1;
end

%feature mapping
if(strcmp(opts.kernel,'RBF'))%RBF kernel
    if(isfield(opts,'Zinit'))
        Z = opts.Zinit;
    else
        Z = X(:,randsample(N, opts.M));
    end
    D2 = Euclid2(Z,X,'col',0);
    sigma0 = real(mean(sqrt(min(D2,[],1))));
    gamma2 = 1./(2*(sigma0*opts.sig_scl).^2);
    F = [exp(-gamma2*D2);ones(1,N)];
elseif(strcmp(opts.kernel,'linear'))%linear kernel
    F = [X;ones(1,N)];
else
    error('Bad Type');
end
G = eye(size(F,1));
G(end,end) = 0;
G = sparse(G);

%normalize lambda
lambda = 1e-4*N/(size(F,1)-1);

V = (F*F'+lambda*G)\(F*Y');
model.opts = opts;
model.V = V;
if(strcmp(opts.kernel,'RBF'))
    model.Z = Z;
    model.gamma2 = gamma2;
end

end