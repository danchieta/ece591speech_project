function [X center_time] = make_snaps(x, win_duration, overlap_duration, wintype)
	
	winlen = ceil(win_duration*x.fs); % window length in number of samples
	step = ceil((win_duration - overlap_duration)*x.fs); % overlap in number of samples

	if strcmp(lower(wintype),'hamming')
		window = hamming(winlen);
	elseif strcmp(lower(wintype),'hanning')
		window = hanning(winlen);
	elseif strcmp(lower(wintype),'bartlett')
		window = hanning(bartlett);
	elseif strcmp(lower(wintype),'blackman')
		window = hanning(blackman);
	elseif strcmp(lower(wintype),'rectwin')
		window = hanning(rectwin);
	end

	% window = window/sum(window);

	X = overlap(x.sound, window, step);

end
