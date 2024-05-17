function [binary_stream] = img2binary(img)
    % img2binary Convert an image to a binary stream
    
    img = uint8(img);
  
    binary_stream = reshape(dec2bin(img(:), 8).'-'0', [], 1);
end