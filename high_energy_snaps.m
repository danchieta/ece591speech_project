function [X energy index] = high_energy_snaps(X_input, threshold)

	energy = sum(X_input.^2);

	index = find(energy/max(energy) > threshold);
	X = X_input(:,index);

end
