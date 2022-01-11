function [out_img] = apply_mask(img,mask)
%APPLY_MASK Summary of this function goes here
%   Detailed explanation goes here

out_img = img.*mask;

end

