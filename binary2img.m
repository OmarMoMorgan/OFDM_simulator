function [img] = binary2img(binary_stream, img_size)
    % binary2img Convert a binary stream back to an image
    % binary_stream: vector of 0s and 1s for the binary representation of
    % the image
    % img_size: vector for the original dimensions of the image
    
    % Reshape stream to 8-bit groupings
    num_pixels = prod(img_size);
    binary_matrix = reshape(binary_stream, 8, num_pixels).';
    
    img = uint8(bin2dec(char(binary_matrix + '0')));
    
    img = reshape(img, img_size);
end