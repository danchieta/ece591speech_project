input_dir = '../id10157/31g1Oo0Ih-A/';
input_file = '00002.wav';

[x.sound, x.fs] = audioread([input_dir input_file]);

% sound(x.sound, x.fs)

win_duration = 30e-3;
overlap_duration = 10e-3;
winlen = ceil(win_duration*x.fs); % window length in number of samples
step = ceil((win_duration - overlap_duration)*x.fs); % overlap in number of samples

window = hamming(winlen);

x.overlap_matrix = overlap(x.sound, window, step);

x.energy = sum(x.overlap_matrix.^2);

ind_highenergy = find(x.energy/max(x.energy) > 0.12);
x.snaps_highenergy = x.overlap_matrix(:,ind_highenergy);

% sound(x.snaps_highenergy(:),x.fs);

nfft = 2^ceil(log2(winlen));
x.spectrum_ofhigh = fft(x.snaps_highenergy,nfft);
x.spectrum_ofhigh = abs(x.spectrum_ofhigh(1:nfft/2,:)).^2;

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

ncepstrum = 50;

n = (1:ncepstrum)';
k = (1:K);

W = cos(n.*(k-.5)*pi/K);

x.cepstrum_coef = W*x.log_spectrum;
x.cepstrum_coef_centr = x.cepstrum_coef-mean(x.cepstrum_coef,2);

col = 50;
figure(1)
subplot(211)
plot(10*log10(abs(x.spectrum_ofhigh(:,col))))
subplot(212)
plot(10*log10(abs(x.smooth_spectrum(:,col))))

figure(2)
for l = 1:5
	subplot(510 +l)
	plot(x.cepstrum_coef_centr(:,5+l))
end
