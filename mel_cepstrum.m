function [coefs, centr_coefs] = mel_cepstrum(spectrum, ncepstrum)
%MEL_CEPSTRUM calculates the mel cepstrum coefficients given the spectrum of
%the signal 

	log_spectrum = log(spectrum);
	[K, N] = size(spectrum);

	n = (1:ncepstrum)';
	k = (1:K);

	W = cos(n.*(k-.5)*pi/K);

	coefs = W*log_spectrum;
	centr_coefs = (coefs - mean(coefs,2))./std(coefs,0,2);
end
