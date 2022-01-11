function [output] = average_Images(img_array)
%AVERAGE_IMAGES Summary of this function goes here
%   Detailed explanation goes here
output = zeros(size(img_array(:,:,1)));

for i = 1:size(img_array, 3) 
    output = output + img_array(:,:,i);    
end

output = output./size(img_array,3);

end

