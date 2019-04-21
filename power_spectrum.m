function [X f_index] = power_spectrum(X_input, fs)

	[M, C] = size(X_input);
	nfft = 2^(ceil(log2(M)));

	f_index = fs*(0:nfft/2-1)/nfft;

	X = fft(X_input,nfft);
	X = abs(X(1:nfft/2,:)).^2;

end
