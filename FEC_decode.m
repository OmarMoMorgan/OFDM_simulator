function [decoded_stream] = FEC_decode(encoded_stream)
    polys = [3, 5, 7];
    trellis = poly2trellis(3, polys);

    % Define decoding parameters
    tblen = 5 * log2(trellis.numStates);  
    
    % Perform Viterbi decoding
    decoded_stream = vitdec(encoded_stream, trellis, tblen, 'trunc', 'hard');

end