function [output] = contrast_piecewise(input, a, b)
%CONTRAST_PIECEWISE Summary of this function goes here
%   Detailed explanation goes here
input = double(input);
out = zeros(size(input, 1), size(input, 2));

r_max = max(max(input));
r_min = min(min(input));

slope1 = (a(2)-r_min)/(a(1)-r_min);
slope2 = (b(2)-a(2))/(b(1)-a(1));
slope3 = (r_max-b(2))/(r_max-b(1));

for i = 1:size(input, 1)
    for j = 1:size(input, 2)
        if input(i,j) <= a(1)
            out(i,j) = input(i,j) * slope1;
        elseif input(i,j) <= b(1) && input(i,j) > a(1)
            out(i,j) = input(i,j) * slope2 + (a(2) - slope2 * a(1));
        else
            out(i,j) = input(i,j) * slope3 + (b(2) - slope3 * b(1));
        end
    end
end
output = out;
end

