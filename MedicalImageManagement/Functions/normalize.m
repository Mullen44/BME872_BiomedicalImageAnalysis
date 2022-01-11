function [output] = normalize(img)
%NORMALIZE Summary of this function goes here
%   Detailed explanation goes here
temp = img - min(min(img));
output = temp./max(max(abs(img)));
end

