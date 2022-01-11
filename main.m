%% Lab 2 - Contrast Enhancement of Mammogram Images
% BME 872 Image Analysis
% Andrew Mullen & Spencer Carrick
clear all;
close all;
clc;

% Add Lab 1 Functions to path (included it in the zip file so don't have to
% do this
%addpath(genpath('/Users/andrewmullen/Desktop/Winter 2021/BME 872/Lab1'));
% Add Lab 2 data to path
addpath('Mammo1');

%% 2.1 Contrast Stretching
% Load in images
% Specify which files
files = ["mdb015.pgm", "mdb082.pgm", "mdb315.pgm"];

% Read in images
for i = 1:3 %length(files)
    
    [img(:,:,i), ~] = imageRead(files(i), 'pgm');
    img = double(img);
    [imgBin(:,i), ~, imgFreq(:,i)] = intensityHistogram(img(:,:,i), 200);
    inputVector(:,i) = reshape(img(:,:,i), [1, 1024*1024]);
    disp('Done Image');
    
    imgContrast(:,:,i) = contrast_stretch(img(:,:,i));
    [imgContrastBin(:,i), ~, imgContrastFreq(:,i)] = intensityHistogram(imgContrast(:,:,i), 200);
    outputVector(:,i) = reshape(imgContrast(:,:,i), [1 1024*1024]);
    disp('Done Image Contrast')
    
end

% Load in Histograms after for speed in recalculating
%imgBin = load('imgBin.mat').imgBin; imgFreq = load('imgFreq.mat').imgFreq;
%imgContrastBin = load('imgContrastBin.mat').imgContrastBin; imgContrastFreq = load('imgContrastFreq.mat').imgContrastFreq;


%% Plot all images
for i = 1:3
    
    figure;
    sgtitle(files(i));
    
    subplot(3,2,1); imshow(img(:,:,i), []); title('Original Image');
    
    subplot(3,2,2); bar(imgBin(2:200, i), imgFreq(2:200, i)); title('Original Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,3); imshow(imgContrast(:,:,i), []); title('Contrast Stretched Image');
    
    subplot(3,2,4); bar(imgContrastBin(2:200, i), imgContrastFreq(2:200, i)); title('Contrast Stretched Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,[5 6]); scatter(inputVector(:, i), outputVector(:, i)); xlabel('Input Graylevel Intensity'); ...
        ylabel('Output Graylevel Intensity');    
    
end

%% Visualize the images
file = dir('Mammo1');
file(1:2) = [];
figure;
for i = 1:11
    [img(:,:,i), ~] = imageRead(file(i).name, 'pgm');
    subplot(4,3,i); imshow(img(:,:,i), []);
end

%% Contrast Piecewise
A1 = [110, 90, 100]; A2 = 25;
B1 = [200, 190, 220]; B2 = [210, 190, 220];

img = double(img);
i = 1;
for j = [1, 5, 10] %length(files)
    
    A = [A1(i), A2]; B = [B1(i), B2(i)];
    
    [imgBin(:,i), ~, imgFreq(:,i)] = intensityHistogram(img(:,:,j), 200);
    inputVector(:,i) = reshape(img(:,:,j), [1, 1024*1024]);
    disp('Done Image');
    
    imgPiece(:,:,i) = contrast_piecewise(img(:,:,j), A, B);
    [imgContrastBin(:,i), ~, imgContrastFreq(:,i)] = intensityHistogram(imgPiece(:,:,i), 200);
    outputVector(:,i) = reshape(imgPiece(:,:,i), [1 1024*1024]);
    disp('Done Image Contrast')
    i = i+1;
end

% Load in Histograms after for speed in recalculating
%imgBin = load('imgBin.mat').imgBin; imgFreq = load('imgFreq.mat').imgFreq;

%% Plot contrast piecewise
marker = [1, 5, 10];
files = ["mdb015.pgm", "mdb082.pgm", "mdb315.pgm"];
for i = 1:3
    
    figure;
    sgtitle(files(i));
    
    subplot(3,2,1); imshow(img(:,:,marker(i)), []); title('Original Image');
    
    subplot(3,2,2); bar(imgBin(2:200, i), imgFreq(2:200, i)); title('Original Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,3); imshow(imgContrast(:,:,i), []); title('Contrast Piecewise Image');
    
    subplot(3,2,4); bar(imgContrastBin(2:200, i), imgContrastFreq(2:200, i)); title('Contrast Piecewise Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,[5 6]); scatter(inputVector(:, i), outputVector(:, i)); xlabel('Input Graylevel Intensity'); ...
        ylabel('Output Graylevel Intensity');    
    
end


%% Contrast Highlight
marker = [1, 5, 10];

A = [125, 100, 100];
B = [200, 170, 205];
Imin = 50;

for i = 1:3 %length(files)
    
    [imgBin(:,i), ~, imgFreq(:,i)] = intensityHistogram(img(:,:,marker(i)), 200);
    inputVector(:,i) = reshape(img(:,:,marker(i)), [1, 1024*1024]);
    disp('Done Image');
    
    imgHighlight(:,:,i) = contrast_highlight(img(:,:,marker(i)), A(i), B(i), Imin);
    [imgContrastBin(:,i), ~, imgContrastFreq(:,i)] = intensityHistogram(imgHighlight(:,:,i), 200);
    outputVector(:,i) = reshape(imgHighlight(:,:,i), [1 1024*1024]);
    disp('Done Image Contrast')

end

% Load in Histograms after for speed in recalculating
%imgBin = load('imgBin.mat').imgBin; imgFreq = load('imgFreq.mat').imgFreq;
%imgContrastBin = load('imgContrastHighBin').imgContrastBin; imgContrastFreq = load('imgContrastHighFreq').imgContrastFreq;
%% Plot contrast highlight
marker = [1, 5, 10];
files = ["mdb015.pgm", "mdb082.pgm", "mdb315.pgm"];
for i = 1:3
    
    figure;
    sgtitle(files(i));
    
    subplot(3,2,1); imshow(img(:,:,marker(i)), []); title('Original Image');
    
    subplot(3,2,2); bar(imgBin(2:200, i), imgFreq(2:200, i)); title('Original Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,3); imshow(imgContrast(:,:,i), []); title('Contrast Highlight Image');
    
    subplot(3,2,4); bar(imgContrastBin(2:200, i), imgContrastFreq(2:200, i)); title('Contrast Highlight Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,[5 6]); scatter(inputVector(:, i), outputVector(:, i)); xlabel('Input Graylevel Intensity'); ...
        ylabel('Output Graylevel Intensity');    
    
end

%% Look up table
% Specify File
marker = [1, 5, 10];

% Create input values from 0-255
x = [0:255].^2;
% Create transfer function look up values for squared trasnfer Transfer function
T = 255*x./max(x);

for i = 1:3 %length(files)
    
    [imgBin(:,i), ~, imgFreq(:,i)] = intensityHistogram(img(:,:,marker(i)), 200);
    inputVector(:,i) = reshape(img(:,:,marker(i)), [1, 1024*1024]);
    disp('Done Image');
    
    imgTrans(:,:,i) = contrast_tfrm_curve(img(:,:,marker(i)), T);
    [imgTransBin(:,i), ~, imgTransFreq(:,i)] = intensityHistogram(imgTrans(:,:,i), 200);
    outputVector(:,i) = reshape(imgTrans(:,:,i), [1 1024*1024]);
    disp('Done Image Transformation')

end

% Load in Histograms after for speed in recalculating
%imgBin = load('imgBin.mat').imgBin; imgFreq = load('imgFreq.mat').imgFreq;
%imgTransBin = load('imgTransBin.mat').imgTransBin; imgTransFreq = load('imgTransFreq.mat').imgTransFreq;

%% Plot contrast transform curve
marker = [1, 5, 10];
files = ["mdb015.pgm", "mdb082.pgm", "mdb315.pgm"];
for i = 1:3
    
    figure;
    sgtitle(files(i));
    
    subplot(3,2,1); imshow(img(:,:,marker(i)), []); title('Original Image');
    
    subplot(3,2,2); bar(imgBin(2:200, i), imgFreq(2:200, i)); title('Original Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,3); imshow(imgTrans(:,:,i), []); title('Contrast Transform Curve Image');
    
    subplot(3,2,4); bar(imgTransBin(2:200, i), imgTransFreq(2:200, i)); title('Contrast Transform Curve Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,[5 6]); scatter(inputVector(:, i), outputVector(:, i)); xlabel('Input Graylevel Intensity'); ...
        ylabel('Output Graylevel Intensity');    
    
end

%% Histogram Equalization
% Load original image histograms
imgBin = load('imgBin.mat').imgBin;
imgFreq = load('imgFreq.mat').imgFreq;

for i = 1:3 %length(files)
    
    [imgBin(:,i), ~, imgFreq(:,i)] = intensityHistogram(img(:,:,marker(i)), 200);
    inputVector(:,i) = reshape(img(:,:,marker(i)), [1, 1024*1024]);
    disp('Done Image');
    
    imgEqual(:,:,i) = histogramEqualization(img(:,:,marker(i)), imgFreq(:,i));
    [imgEqualBin(:,i), ~, imgEqualFreq(:,i)] = intensityHistogram(imgEqual(:,:,i), 200);
    outputVector(:,i) = reshape(imgEqual(:,:,i), [1 1024*1024]);
    disp('Done Image Transformation')

end

% Load in Histograms after for speed in recalculating
%imgBin = load('imgBin.mat').imgBin; imgFreq = load('imgFreq.mat').imgFreq;
%imgEqualBin = load('imgEqualBin.mat').imgEqualBin; imgEqualFreq = load('imgEqualFreq.mat').imgEqualFreq;

%% Plot histogram equalizers
marker = [1, 5, 10];
files = ["mdb015.pgm", "mdb082.pgm", "mdb315.pgm"];
for i = 1:3
    
    figure;
    sgtitle(files(i));
    
    subplot(3,2,1); imshow(img(:,:,marker(i)), []); title('Original Image');
    
    subplot(3,2,2); bar(imgBin(2:200, i), imgFreq(2:200, i)); title('Original Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,3); imshow(imgEqual(:,:,i), []); title('Histogram Equalization Image');
    
    subplot(3,2,4); bar(imgEqualBin(2:200, i), imgEqualFreq(2:200, i)); title('Histogram Equalization Image Histogram'); ...
        xlabel('Bin Number'); ylabel('Normalized Frequency of Occurence');
    
    subplot(3,2,[5 6]); scatter(inputVector(:, i), outputVector(:, i)); xlabel('Input Graylevel Intensity'); ...
        ylabel('Output Graylevel Intensity');    
    
end

%% Local Enhancement
output = zeros(1024,1024);

for row = 1:16
    for col = 1:16
        % Define indices
        x_index = 64*(row-1)+1:64*row;
        y_index = 64*(col-1)+1:64*col;
        
        % Extract Square to perform histogram equalization
        square = img(x_index, y_index, 1);
        
        % Obtain Histogram
        [Bin, ~, Freq] = intensityHistogram(square, 25);
        
        % Histogram Equalize
        output(x_index, y_index) = histogramEqualization(square, Freq);
        
        disp([row, col])
    end
end

figure;
imshow(output, []); title('Local Contrast Enhancement');