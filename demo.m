clc;
clear all;
close all;
addpath(genpath('./'));

K = 32;
M = 500;

load ./data/corel5k;%Mnist4k or corel5k
data = get_data(data, data.splits{1});

%all the methods use the same anchors to do feature mapping
opts.M = M;
opts.sig_scl = 1.5;
opts.kernel = 'RBF';
opts.Zinit = data.Xtrain(:,randsample(size(data.Xtrain,2), M));

%% SDH
fprintf('SDH:\n');
params.K = K;%hash bits
params.M = M;%number of anchors
params.sig_scl = 1.5;
params.maxItr = 5;
params.kernel = 'RBF';
model = SDHtrain(data.Xretri', data.Yretri', params);%use the database

Btest = SDHtest(data.Xtest', model, 'uint8');
Bretri = compactbit(model.B'>0)';
D = hammDist_mex(Bretri, Btest);
[~, IX] = sort(D, 1, 'ascend');
map1 = MAP(data.Yretri, data.Ytest, IX);
map1

%% TSH_label
fprintf('TSH_label:\n');
tic;H = TSH_label(data.Yretri, K);
model = RidgeReg(data.Xretri, H, opts);

Btest = RidgeReg_test(data.Xtest, model, 'uint8');
Bretri = compactbit(H'>0)';%using the discrete codes is better!!
D = hammDist_mex(Bretri, Btest);
[~, IX] = sort(D, 1, 'ascend');
map2 = MAP(data.Yretri, data.Ytest, IX);
map2

%% TSH_trans
fprintf('TSH_trans:\n');
tic;H = TSH_trans(data.Yretri, 0.5, K, 'Y');
model = RidgeReg(data.Xretri, H, opts);

Btest = RidgeReg_test(data.Xtest, model, 'uint8');
Bretri = compactbit(H'>0)';%using the discrete codes is better!!
D = hammDist_mex(Bretri, Btest);
[~, IX] = sort(D, 1, 'ascend');
map3 = MAP(data.Yretri, data.Ytest, IX);
map3

%% TSH_kernl
fprintf('TSH_kernl:\n');
tic;H = TSH_kernl(data.Yretri, K, struct('ker_type','KINTERS'));%use database
model = RidgeReg(data.Xretri, H, opts);

Btest = RidgeReg_test(data.Xtest, model, 'uint8');
Bretri = compactbit(H'>0)';
D = hammDist_mex(Bretri, Btest);
[~, IX] = sort(D, 1, 'ascend');
map4 = MAP(data.Yretri, data.Ytest, IX);
map4

