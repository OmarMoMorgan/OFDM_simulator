function [out_symbols] = symbol_mapper(bits_stream, type)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    
    if type == "16-QAM"
        bits_per_symbol = 4;
        symbol_indices = bi2de(reshape(bits_stream, bits_per_symbol, []).', 'left-msb');
        qam_constellation = qammod(0:15, 16);
        out_symbols = qam_constellation(symbol_indices + 1);
    elseif type == "BPSK"
        out_symbols = 2 * bits_stream - 1;
    end


end