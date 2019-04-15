addpath('../EM_files/')
load('enrolled_feature.mat');

[label, model, L] = mixGaussEm(x.cepstrum_coef, 2);
