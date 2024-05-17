function filteredSignal = ClipAndFilter(signal, level)
% Clipping and Filtering Method for OFDM PAPR Reduction
clipped = signal;
for i=1:length(clipped)
	if (clipped(i) > level)
		clipped(i) = level;
    end
    if (clipped(i) < -level)
		clipped(i) = -level;
    end
end

filterOrder = 64;
normalizedCutoffFreq = 0.8;
h = fir1(filterOrder, normalizedCutoffFreq);
filteredSignal = filter(h, 1, clipped);


end