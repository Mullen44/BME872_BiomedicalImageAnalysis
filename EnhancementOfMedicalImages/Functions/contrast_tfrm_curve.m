function [output] = contrast_tfrm_curve(input, T)

img = round(input);
out = zeros(size(input, 1), size(input, 2));
I_max = double(max(max(input)));
T_len = double(length(T));
%disp(T_len)

for i = 1:size(input, 1)
    for j = 1:size(input, 2)
        index = round(T_len*double(img(i,j))/I_max);
        if index == 0
            index = index + 1;
        end
        %disp(index)
        out(i,j) = T(index);
    end
end

output = out;

end

