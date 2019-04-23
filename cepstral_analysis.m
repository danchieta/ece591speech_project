function [x] = cepstral_analysis(x, win_duration, overlap_duration,nfft,...
	smooth_nwin, ncepstrum)
	

	x.overlap_matrix = make_snaps(x, win_duration, overlap_duration, 'hamming');
	[~,ncol] = size(x.overlap_matrix);

	x.time_index = (0:ncol-1)*(win_duration-overlap_duration) + win_duration/2;

	[x.snaps_highenergy, x.energy, x.index_highe] =...
		high_energy_snaps(x.overlap_matrix, 0.15);

	[x.spectrum_ofhigh, x.spec_index] = power_spectrum(x.snaps_highenergy,...
		x.fs,nfft);

	[x.smooth_spectrum, x.sm_spec_index] = mel_filterbank(x.spectrum_ofhigh,...
		x.spec_index, smooth_nwin);

	[x.cepstrum_coef, x.cepstrum_coef_centr] =...
		mel_cepstrum(x.smooth_spectrum, ncepstrum);

end
