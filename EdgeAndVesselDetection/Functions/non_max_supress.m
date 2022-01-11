function [out, xNMS, yNMS] = non_max_supress(img, W, H)
%NON_MAX_SUPRESS Summary of this function goes here
%   Detailed explanation goes here
out = zeros(size(img,1), size(img,2));
xNMS = zeros(size(img,1), size(img,2));
yNMS = zeros(size(img,1), size(img,2));

% Horizontal Supression
for i = 1:size(out,1)
    for j = ((W+1)/2):size(out,2)-((W-1)/2)
        horSeg = img(i, j-((W-1)/2):j+((W-1)/2));
        %[~, horMaxIndex] = max(horSeg);
        maxHor = max(horSeg);
        
        if img(i,j) == maxHor %horMaxIndex == (W+1)/2
            yNMS(i,j) = img(i,j);
        end
    end
end

% Vertical Suppression
for j = 1:size(out,2)
    for i = ((H+1)/2):size(out,1)-((H-1)/2)
        vertSeg = img(i-((H-1)/2):i+((H-1)/2),j);
        %[~, vertMaxIndex] = max(vertSeg);
        maxVert = max(vertSeg);
        
        if img(i,j) == maxVert%vertMaxIndex == (H+1)/2
            xNMS(i,j) = img(i,j);
        end
    end
end

out = yNMS + xNMS;

end

