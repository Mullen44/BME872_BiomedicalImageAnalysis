function [img, info] = imageRead(path, imageFormat)
%IMAGEREAD Summary of this function goes here
%   Detailed explanation goes here
img = []; info = [];
if imageFormat == "mhd"
    [img, info] = read_mhd(path);
    img = img.data;
end
if imageFormat == "raw"
    
    
end
if imageFormat == "png"
    img = imread(path);
end
if imageFormat == "dcm"
    img = dicomread(path);
    info = dicominfo(path);
end
if imageFormat == "mat"
    img = load(path).vol;
end
if imageFormat == "pgm"
    img = imread(path);
end
if imageFormat == "tif"
    img = read(path);
end
if imageFormat == "jpg"
    img = imread('path');
end

end

