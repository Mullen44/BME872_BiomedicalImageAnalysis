function [output] = spatial_filter_2(input, h)
%SPATIAL_FILTER_2 Summary of this function goes here
%   Detailed explanation goes here
if length(size(input)) == 3
    input = rgb2gray(input);
end

% Cast to double
input = double(input);

% Obtain filter normalization coefficeint
coeff = 1/sum(sum(h));
if sum(sum(h)) == 0
    coeff = 1;
end

output = conv2(input, h);


end

