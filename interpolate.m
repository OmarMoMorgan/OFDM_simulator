function interpTime = interpolate(PilotsIndc,gains,r,c)
interpFreq = zeros(r, c);
interpTime = zeros(r, c);
for o = 1 :2: c
f_real = fit(PilotsIndc',gains(:,ceil(o/2)),'cubicinterp');
interpFreq(:,o) = f_real(1:r);
end
for u = 1 : r
    f_imag = fit([1:2:c]',interpFreq(u,1:2:end)','cubicinterp');
    interpTime(u,:) = f_imag(1:c);
end
end