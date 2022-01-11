function [out] = contrast_stretch(img)
%CONTRAST_STRETCH Summary of this function goes here
%   Detailed explanation goes here
img = double(img);
r_max = max(max(img));
r_min = min(min(img));
out = zeros(size(img, 1), size(img, 2));

out = 255 .* ((1/(r_max - r_min)).*img - (r_min/(r_max-r_min)));        

end

