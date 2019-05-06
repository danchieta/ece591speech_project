% Chris Martin speech
input_dir = '../id10157/31g1Oo0Ih-A/';
input_file = '00002.wav';

% Cillian Murphy coefficients
% input_dir = '../id10166/8h57d48MzGw/';
% input_file = '00002.wav';

[x.sound, x.fs] = audioread([input_dir input_file]);
% sound(x.sound, x.fs)

% duration in seconds
win_duration = 30e-3;
overlap_duration = 10e-3;
nfft = 2048;
% number of windows in mel filterbank
smooth_nwin = 256;
% number of cepstrum coefficients
ncepstrum = 128;
% energy threshold relative to median
% energy_threshold = 1.5;

x = cepstral_analysis(x, win_duration, overlap_duration, nfft,...
	smooth_nwin, ncepstrum);

col = 4;

figure(1)
plot(x.spec_index, 10*log10(abs(x.spectrum_ofhigh(:,col))))
hold on
plot(x.sm_spec_index, 10*log10(abs(x.smooth_spectrum(:,col))))
hold off
legend('Spectrum', 'Filtered Spectrum')
xlabel('Frequency (Hz)')
ylabel('20log_{10}|X(f)|')

[~, ncols] = size(x.cepstrum_coef);

k = round(1:ncols/5:ncols);
t = x.time_index(x.index_highe);
t = t(k);

figure(2)
for l = 1:5
	subplot(510 +l)
	plot(x.cepstrum_coef(:,k(l)))
	title(['Cepstrum coefficients t = ' num2str(t(l)) 's'])
	xlabel('m')
	ylabel('c_m')
end

figure(3)
for l = 1:5
	subplot(510 +l)
	plot(x.cepstrum_coef_centr(:,k(l)))
	title(['Centered cepstrum coefficients t = ' num2str(t(l)) 's'])
	xlabel('m')
	ylabel('c_m')
end

figure(4)
plot(x.time_index, x.energy)
hold on
% plot(x.time_index, ones(1,length(x.time_index))*1.5*median(x.energy))
plot(x.time_index, ones(1,length(x.time_index))*.15*max(x.energy))
hold off
legend('Energy', '0.15*Maximum')
title('Short-time Energy')
xlabel('t(seconds)')
ylabel('E(t)')

ceps_center_coef = x.cepstrum_coef_centr;
% save('unrolled_feature.mat','x');
