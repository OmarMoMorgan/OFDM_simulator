function [encoded_stream] = FEC_code(binary_stream, code_rate)

    if code_rate == 1/2
        polys = [3, 7];
        trellis = poly2trellis(3, polys);
        encoded_stream = convenc(binary_stream, trellis);
    elseif code_rate == 1/3
        polys = [3, 5, 7];
        trellis = poly2trellis(3, polys);
        encoded_stream = convenc(binary_stream, trellis);
    else
        polys = [3, 7];
        trellis = poly2trellis(3, polys);
        encoded_stream = convenc(binary_stream, trellis,[1;1;0]);
    end

end