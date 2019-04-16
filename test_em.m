addpath('./EM_files/')
load('enrolled_feature.mat');

[label, model_chris, L] = mixGaussEm(x.cepstrum_coef_centr, 7);

gm = gmdistribution(model_chris.mu, model_chris.Sigma);

save('chris_martin_model.mat', 'model_chris')
