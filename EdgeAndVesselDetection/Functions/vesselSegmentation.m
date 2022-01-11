function [output, DSC] = vesselSegmentation(input, GT, filter, thresh)
%VESSELSEGMENTATION Summary of this function goes here
%   Detailed explanation goes here
if length(size(input)) == 3
    input = rgb2gray(input);
end

filter = [1 4 7 4 1;
    4 20 33 20 4;
    7 33 55 33 7;
    4 20 33 20 4;
    1 4 7 4 1];

% Gaussian Filter
imgFilt = spatial_filter(input, filter);
% Gradient Calculation
[xGrad, yGrad, magGrad] = derivativeFilterPlot(imgFilt, 'Sobel', 'Healthy');
% Filter Gradient
gradMagFilt = spatial_filter(magGrad, filter);
% Non Max Supression
NMS = non_max_supress(gradMagFilt, 7, 7);
% Threshold
thresh = threshold(NMS, thresh);
% Connect pixels with its nearest neighbour
connect = connectNN(thresh);
% Fill segments
seg = imfill(connect);
seg = imfill(seg);

% Create 1D arrays of the 
GTarray = reshape(GT, [1, numel(GT)]);
segArray = reshape(seg, [1, numel(seg)]);

% Calculate intersection of the two arrays
intersection = sum(double(GTarray).*segArray);
DSC = (2*intersection + 1)/(sum(GTarray) + sum(segArray) + 1);

% Plot Images
figure;
subplot(3,2,1:2);
imshow(input, []); title('Input image');

subplot(323);
imshow(gradMagFilt(1900:2200, 1700:2000), []); title('Gradient magnitude with gaussian filter');

subplot(324);
imshow(NMS(1900:2200, 1700:2000), []); title('Non maximum suppression');

subplot(325)
imshow(seg, []); title('Segmentation');

subplot(326);
imshow(GT, []); title('Ground Truth');

output = [input, gradMagFilt, NMS, seg, GT];

end

