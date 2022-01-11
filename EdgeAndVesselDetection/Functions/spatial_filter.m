function [output] = spatial_filter(input,h)
%SPATIAL_FILTER Function takes an image and filter inputs and outputs the
%filtered image
%   Detailed explanation goes here
% Turn rgb to gray scale
if length(size(input)) == 3
    input = rgb2gray(input);
end

% Cast to double
input = double(input);

% Obtain filter normalization coefficeint
%coeff = 1/sum(sum(h));
if sum(sum(h)) == 0
    coeff = 1;
end

output = conv2(input, h, 'same');
%output = coeff.*output;


end

