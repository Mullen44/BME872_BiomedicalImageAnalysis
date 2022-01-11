function [] = imageWrite(data, path, imageType)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if imageType == 'png'
    imwrite(uint16(data), strcat(path, '.png'));
elseif imageType == 'dcm'
    dicomwrite(data, strcat(path, '.dcm'));    
elseif imageType == 'mat'
    save(path, 'data');
end
end

