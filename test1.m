% Chris Martin speech
% input_dir = '../id10157/31g1Oo0Ih-A/';
% input_file = '00002.wav';

% Cillian Murphy coefficients
input_dir = '../id10166/8h57d48MzGw/';
input_file = '00004.wav';

[x.sound, x.fs] = audioread([input_dir input_file]);
% sound(x.sound, x.fs)

% durations in seconds
win_duration = 30e-3;
overlap_duration = 10e-3;
% number of windows in mel filterbank
smooth_nwin = 10;
% number of cepstrum coefficients
ncepstrum = 100;

x = cepstral_analysis(x, win_duration, overlap_duration, smooth_nwin, ncepstrum);

col = 27;

figure(1)
plot(x.spec_index, 10*log10(abs(x.spectrum_ofhigh(:,col))))
hold on
plot(x.sm_spec_index, 10*log10(abs(x.smooth_spectrum(:,col))))
hold off

[~, ncols] = size(x.cepstrum_coef);

k = round(1:ncols/5:ncols);

figure(2)
for l = 1:5
	subplot(510 +l)
	plot(x.cepstrum_coef(:,5+l))
	title('Cepstrum coefficients')
end

figure(3)
for l = 1:5
	subplot(510 +l)
	plot(x.cepstrum_coef_centr(:,5+l))
	title('Centered cepstrum coefficients')
end

ceps_center_coef = x.cepstrum_coef_centr;
% save('unrolled_feature.mat','x');
