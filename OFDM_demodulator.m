function [signal_equalized_zero , signal_equalized_wiener] = OFDM_demodulator(CycPref,n,SC,ychan,pilot_value,pilots_index,SNR)
%This is demodlator for ofdm
%Noise is not estiated here so you will just have to pass it 
%cycPref is the number of samples for Cyclic prefix
%n is the number of symbols that you sent (in an actual world this could be changed a little bit)
%pilot_value is the value of the pilot here I am assuming it is a single
%value 
%pilots_index is the indices of where are the pilots
%SNR is the signal to noise ratio

%in this step I am assuming that the number of bits is fied and that I am
%adding some redudancy in the first for Zeros and pilots
n = n * 4/3;

ychan = ychan(1:n+CycPref * n/SC);

% Note need to adjust the dimensions after conv
X_Recieved = reshape(ychan,SC+CycPref,[]);

X_Recieved = X_Recieved(CycPref+1:end,:);



y_parrallel = fft(X_Recieved);
%y_parrallel = fft(X_Recieved,SC);



%gains_zero = y_parrallel(pilots_index,1:2:end)./pilot_value;
gains_zero = y_parrallel(pilots_index,1:end)./pilot_value;

interptime_real = interpolate(pilots_index,real(gains_zero),SC,n/SC);
interptime_imag = interpolate(pilots_index,imag(gains_zero),SC,n/SC);

estimated_channel = interptime_real + 1i*interptime_imag;

signal_equalized_zero = y_parrallel./estimated_channel;

noise_var = 10^(-SNR/10);
%noise_var = var(y_parrallel(pilots_index,1:end) - estimated_channel(pilots_index,1:end) .* pilot_value);
%noise_var = var(y_parrallel(pilots_index,1:end) -  pilot_value);
%size(noise_var)



H_est_mag2 = abs(estimated_channel).^2;
W = conj(estimated_channel) ./ (H_est_mag2 + noise_var);

%size(W)

%y_parrallel_freq = fft(y_parrallel, SC);
%y_parrallel_freq = y_parrallel;

%signal_equalized_wiener_freq = W.*y_parrallel_freq;
signal_equalized_wiener = W.*y_parrallel;

%signal_equalized_wiener = ifft(signal_equalized_wiener_freq,SC);

%W - 1./estimated_channel

end