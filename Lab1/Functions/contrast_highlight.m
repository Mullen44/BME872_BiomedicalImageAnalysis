function [output] = contrast_highlight(input, A, B, Imin)

input = double(input);
temp = zeros(size(input, 1), size(input, 2));

for i = 1:size(input, 1)
    for j = 1:size(input, 2)
        if input(i,j) <= A || input(i,j) >= B
            temp(i,j) = Imin;
        else
            temp(i,j) = input(i,j);
        end
    end
end

output = temp;

end

