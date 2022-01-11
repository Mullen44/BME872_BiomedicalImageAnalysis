function [xGradient, yGradient, gradientMagnitude] = derivativeFilterPlot(input, filterChoice, name)
%DERIVATIVEFILTERPLOT Summary of this function goes here
%   Detailed explanation goes here

filter = derivative_kernel(filterChoice);

yGradient = spatial_filter(input, filter);
xGradient = spatial_filter(input, filter);

if size(xGradient) == size(yGradient)
    gradientMagnitude = sqrt(xGradient.^2 + yGradient.^2);
else
    gradientMagnitude = sqrt(xGradient(:,2:(size(xGradient,2)-1)).^2 + yGradient(2:(size(yGradient,1)-1),1).^2);

end

%figure;
%subplot(231); imshow(yGradient, []); title([name, filterChoice, ' Y Gradient']);
%subplot(232); imshow(xGradient, []); title([name, filterChoice, ' X Gradient']);
%subplot(233); imshow(gradientMagnitude, []); title([name, filterChoice, ' Gradient Magnitude']);
%subplot(234); imshow(yGradient(1900:2200, 1700:2000),[]); title([name, filterChoice, ' Y Gradient zoomed']);
%subplot(235); imshow(xGradient(1900:2200, 1700:2000),[]); title([name, filterChoice, ' X Gradient zoomed']);
%subplot(236); imshow(gradientMagnitude(1900:2200, 1700:2000),[]); title([name, filterChoice, ...
    %' Gradient Magnitude zoomed in']);

end

