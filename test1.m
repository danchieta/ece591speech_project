input_dir = '../id10166/8h57d48MzGw/';
input_file = '00004.wav';

[x.sound, x.fs] = audioread([input_dir input_file]);

% sound(x.sound, x.fs)

% durations in seconds
win_duration = 30e-3;
overlap_duration = 10e-3;

x.overlap_matrix = make_snaps(x, win_duration, overlap_duration, 'hamming');

[x.snaps_highenergy, x.energy, index] = high_energy_snaps(x.overlap_matrix, 0.22);
% sound(x.snaps_highenergy(:),x.fs);

x.spectrum_ofhigh = power_spectrum(x.snaps_highenergy);

f_index = linspace(0, x.fs/2, nfft/2);
f_mel_index = 1000*log2(1 + f_index/1000);

smooth_win_len = 25;
win1 = bartlett(smooth_win_len); % window for smoothing the spectrum
win1 = win1/sum(win1);

[M, K] = size(x.spectrum_ofhigh);
x.smooth_spectrum = zeros(M-smooth_win_len+1, K);

for k=1:K
	x.smooth_spectrum(:,k) = conv(x.spectrum_ofhigh(:,k), win1, 'valid');
end

% x.smooth_spectrum = x.smooth_spectrum(1:4:end,:);
x.log_spectrum = log(x.smooth_spectrum);
[K, N] = size(x.log_spectrum);

ncepstrum = 100;

n = (1:ncepstrum)';
k = (1:K);

W = cos(n.*(k-.5)*pi/K);

x.cepstrum_coef = W*x.log_spectrum;
x.cepstrum_coef_centr = x.cepstrum_coef-mean(x.cepstrum_coef,2);
x.cepstrum_coef_centr = x.cepstrum_coef./var(x.cepstrum_coef,0,2);

col = 27;
figure(1)
subplot(211)
plot(10*log10(abs(x.spectrum_ofhigh(:,col))))
subplot(212)
plot(10*log10(abs(x.smooth_spectrum(:,col))))

figure(2)
for l = 1:5
	subplot(510 +l)
	plot(x.cepstrum_coef(:,5+l))
end

figure(3)
for l = 1:5
	subplot(510 +l)
	plot(x.cepstrum_coef_centr(:,5+l))
end

ceps_center_coef = x.cepstrum_coef_centr;
save('unrolled_feature.mat','x');
