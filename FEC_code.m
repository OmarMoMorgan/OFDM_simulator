function [encoded_stream] = FEC_code(binary_stream)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    polys = [3, 5, 7];
    trellis = poly2trellis(3, polys);
    encoded_stream = convenc(binary_stream, trellis);


end