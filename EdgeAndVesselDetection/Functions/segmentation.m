function [out] = segmentation(input)
%SEGMENTATION Summary of this function goes here
%   Detailed explanation goes here
out = zeros(size(input));
segment = 0;
count = 0;
for i = 1:size(input, 1)
    for j = 1:size(input, 2)
        if input(i,j) == 1 
            if j+6 < 10
                if ismember(input(i,j:j+6), 1)
                    if segment == 0
                        segment = 1;
                        count = max(find(input(i, j:j+1)));
                    end
                end
            end
        end
        
        if count ~= 0 && segment == 1
            out(i,j) = 1;
            count = count - 1;
        end
            
        if count == 0
            segment = 0;
        end
            
    end
end
end

