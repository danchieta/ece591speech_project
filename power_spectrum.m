function [X] = power_spectrum(X_input)

	[M, C] = size(X_input);
	nfft = 2^(ceil(log2(M)));

	X = fft(X_input,nfft);
	X = abs(X_input(1:nfft/2,:)).^2;

end
