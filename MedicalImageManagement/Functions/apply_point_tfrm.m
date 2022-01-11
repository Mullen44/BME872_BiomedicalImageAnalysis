function [out_img] = apply_point_tfrm(img, C, B)
%APPLY_POINT_TFRM Summary of this function goes here
%   Detailed explanation goes here

out_img = img.*C + B;

end

