function [bit_stream] = symbol_demapper(signal, type)

if type == "16-QAM"
    demodulated_signal = qamdemod(signal, 16);
    bit_stream = de2bi(demodulated_signal, 4, "left-msb");
    bit_stream = bit_stream';
    bit_stream = bit_stream(:)';
  
elseif type == "BPSK"
    bit_stream = signal > 0;
end




end