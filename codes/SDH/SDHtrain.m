function model = SDHtrain(X, y, opts)
%X: each row is a sample
%y: column vector

tic;
[N,d] = size(X);

%initial Z for kernel version
if(strcmp(opts.kernel,'RBF'))
    Z = X(randsample(N, opts.M),:);
end
clear X1 X2 Z1 Z2;

%feature mapping
if(strcmp(opts.kernel,'linear'))
    PhiX = [X, ones(N,1)];
elseif(strcmp(opts.kernel,'RBF'))
    D2 = Euclid2(X, Z, 'row', 0);
    sigma = mean(min(D2,[],2).^0.5)*opts.sig_scl;
    PhiX = exp(-D2/(2*sigma*sigma));
    PhiX = [PhiX, ones(N,1)];
else
    error('bad type');
end
clear X D2;

gmap.lambda = 1; gmap.loss = 'L2';
Fmap.type = opts.kernel;
Fmap.nu = 1e-5; %  penalty parm for F term
Fmap.lambda = 1e-2;

% call SDH
randn('seed',3);
Binit = sign(randn(N,opts.K));
[~, F, B] = SDH(PhiX,y,Binit,gmap,Fmap,[],opts.maxItr,1);
model.B = double(B'>0);

model.W = F.W;
model.opts = opts;
if(strcmp(opts.kernel,'RBF'))
    model.anchor = Z;
    model.sigma = sigma;
    if(exist('feat_perm','var'))
        model.feat_perm = feat_perm;
    end
    if(exist('R','var'))
        model.R = R;
    end
end

model.time = toc;

end