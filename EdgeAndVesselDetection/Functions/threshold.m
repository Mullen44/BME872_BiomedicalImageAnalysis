function [output] = threshold(input, threshold)
%THRESHOLD Summary of this function goes here
%   Detailed explanation goes here

output = zeros(size(input));
input = (input-min(min(input)))./(max(max(input))-min(min(input)));

for i = 1:size(input,1)
    for j = 1:size(input,2)
        if input(i,j)>threshold
            output(i,j) = 1;
        end
    end
end
end

