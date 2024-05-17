function [decoded_stream] = FEC_decode(encoded_stream, code_rate)

   if code_rate == 1/2
        polys = [3, 7];
        trellis = poly2trellis(3, polys);
        tblen = 5 * log2(trellis.numStates);  
        decoded_stream = vitdec(encoded_stream, trellis, tblen, 'trunc', 'hard');
    elseif code_rate == 1/3
        polys = [3, 5, 7];
        trellis = poly2trellis(3, polys);
        tblen = 5 * log2(trellis.numStates);  
        decoded_stream = vitdec(encoded_stream, trellis, tblen, 'trunc', 'hard');
    else
        polys = [3, 7];
        trellis = poly2trellis(3, polys);
        tblen = 5 * log2(trellis.numStates);  
        decoded_stream = vitdec(encoded_stream, trellis, tblen, 'trunc', 'hard', [1;1;0]);
   end
   

end