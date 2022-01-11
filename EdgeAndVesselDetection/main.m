%% BME 872 Lab 3
% Automated Edge and Vessel Detection in Retinal Images
% Andrew Mullen & Spencer Carrick

clear all;
close all;
clc;

%% Add Paths
% Data
addpath('diabetic_retinopathy')
addpath('diabetic_retinopathy_manualsegm')
addpath('glaucoma')
addpath('glaucoma_manualsegm')
addpath('healthy')
addpath('healthy_manualsegm')
addpath(genpath('/Users/andrewmullen/Desktop/Winter 2021/BME 872/Lab1'))

%% Part 1 Filtering Functions
% Read in an image
imgDRPath = '08_dr.JPG';
imgDR = imread(imgDRPath);

imgGPath = '08_g.jpg';
imgG = imread(imgGPath);

imgHPath = '08_h.jpg';
imgH = imread(imgHPath);

filter = [1 4 7 4 1;
    4 20 33 20 4;
    7 33 55 33 7;
    4 20 33 20 4;
    1 4 7 4 1];

filter = double(filter);

imgDR_filt = spatial_filter(imgDR, filter);
imgG_filt = spatial_filter(imgG, filter);
imgH_filt = spatial_filter(imgH, filter);


%% Plot part 1
% Diabetic Retinopathy
figure;
subplot(221);
imshow(rgb2gray(imgDR), []); title('Original Diabetic Retinopathy Image');
subplot(222);
imshow(imgDR_filt, []); title('Gaussian Filtered Diabetic Retinopathy Image');
subplot(223);
imshow(rgb2gray(imgDR(1900:2200,1700:2000,:)), []); title('Original zoomed in (1900:2200, 1700:2000)');
subplot(224);
imshow(imgDR_filt(1900:2200,1700:2000), []); title('Filtered zoomed in (1900:2200, 1700:2000)');

% Glaucoma
figure;
subplot(221);
imshow(rgb2gray(imgG), []); title('Original Glaucoma Image');
subplot(222);
imshow(imgG_filt, []); title('Gaussian Filtered Glaucoma Image');
subplot(223);
imshow(rgb2gray(imgG(1900:2200,1700:2000,:)), []); title('Original zoomed in (1900:2200, 1700:2000)');
subplot(224);
imshow(imgG_filt(1900:2200,1700:2000), []); title('Filtered zoomed in (1900:2200, 1700:2000)');

% Healthy
figure;
subplot(221);
imshow(rgb2gray(imgH), []); title('Original Healthy Image');
subplot(222);
imshow(imgH_filt, []); title('Gaussian Filtered Healthy Image');
subplot(223);
imshow(rgb2gray(imgH(1900:2200,1700:2000,:)), []); title('Original zoomed in (1900:2200, 1700:2000)');
subplot(224);
imshow(imgH_filt(1900:2200,1700:2000), []); title('Filtered zoomed in (1900:2200, 1700:2000)');


%% Gradients
% Compute x gradient, y gradient and gradient magnitude
% Diabetic Retinopathy
[xGradientDR_Central, yGradientDR_Central, gradientMagnitudeDR_Central] = derivativeFilterPlot(imgDR_filt, 'Central', ...
    'Diabetic Retinopathy');
[xGradientDR_Forward, yGradientDR_Forward, gradientMagnitudeDR_Forward] = derivativeFilterPlot(imgDR_filt, 'Forward', ...
    'Diabetic Retinopathy');
[xGradientDR_Prewitt, yGradientDR_Prewitt, gradientMagnitudeDR_Prewitt] = derivativeFilterPlot(imgDR_filt, 'Prewitt', ...
    'Diabetic Retinopathy');
[xGradientDR_Sobel, yGradientDR_Sobel, gradientMagnitudeDR_Sobel] = derivativeFilterPlot(imgDR_filt, 'Sobel', ...
    'Diabetic Retinopathy');

% Glaucoma
[xGradientG_Central, yGradientG_Central, gradientMagnitudeG_Central] = derivativeFilterPlot(imgG_filt, 'Central', 'Glaucoma');
[xGradientG_Forward, yGradientG_Forward, gradientMagnitudeG_Forward] = derivativeFilterPlot(imgG_filt, 'Forward', 'Glaucoma');
[xGradientG_Prewitt, yGradientG_Prewitt, gradientMagnitudeG_Prewitt] = derivativeFilterPlot(imgG_filt, 'Prewitt', 'Glaucoma');
[xGradientG_Sobel, yGradientG_Sobel, gradientMagnitudeG_Sobel] = derivativeFilterPlot(imgG_filt, 'Sobel', 'Glaucoma');

% Healthy
[xGradientH_Central, yGradientH_Central, gradientMagnitudeH_Central] = derivativeFilterPlot(imgH_filt, 'Central', 'Healthy');
[xGradientH_Forward, yGradientH_Forward, gradientMagnitudeH_Forward] = derivativeFilterPlot(imgH_filt, 'Forward', 'Healthy');
[xGradientH_Prewitt, yGradientH_Prewitt, gradientMagnitudeH_Prewitt] = derivativeFilterPlot(imgH_filt, 'Prewitt', 'Healthy');
[xGradientH_Sobel, yGradientH_Sobel, gradientMagnitudeH_Sobel] = derivativeFilterPlot(imgH_filt, 'Sobel', 'Healthy');

%% Plot Gradients
figure;
sgtitle('Diabetic Retinopathy Image - Sobel Filter');
subplot(131); imshow(xGradientDR_Sobel(1900:2200,1700:2000), []); title('X Gradient');
subplot(132); imshow(yGradientDR_Sobel(1900:2200,1700:2000), []); title('Y Gradient');
subplot(133); imshow(gradientMagnitudeDR_Sobel(1900:2200,1700:2000), []); title('Gradient Magnitude');

figure;
sgtitle('Healthy Image - Forward Filter');
subplot(131); imshow(xGradientH_Forward(1900:2200,1700:2000), []); title('X Gradient');
subplot(132); imshow(yGradientH_Forward(1900:2200,1700:2000), []); title('Y Gradient');
subplot(133); imshow(gradientMagnitudeH_Forward(1900:2200,1700:2000), []); title('Gradient Magnitude');

figure;
sgtitle('Glaucoma Image - Prewitt Filter');
subplot(131); imshow(xGradientG_Prewitt(1900:2200,1700:2000), []); title('X Gradient');
subplot(132); imshow(yGradientG_Prewitt(1900:2200,1700:2000), []); title('Y Gradient');
subplot(133); imshow(gradientMagnitudeG_Prewitt(1900:2200,1700:2000), []); title('Gradient Magnitude');

%% Plot comparison of filters
figure;
sgtitle('Gradient Magnitude - Healthy Subject')
subplot(221); imshow(gradientMagnitudeH_Central(1900:2200,1700:2000), []); title('Central Derivative Filter');
subplot(222); imshow(gradientMagnitudeH_Forward(1900:2200,1700:2000), []); title('Forward Derivative Filter');
subplot(223); imshow(gradientMagnitudeH_Prewitt(1900:2200, 1700:2000), []); title('Prewitt Derivative Filter');
subplot(224); imshow(gradientMagnitudeH_Sobel(1900:2200, 1700:2000), []); title('Sobel Derivative Filter');

%% Part 2 No-Maxima Suppresion
[NMS3_H_Central, xNMS3_Central, yNMS3_Central] = non_max_supress(gradientMagnitudeH_Central, 3, 3);
[NMS3_H_Forward, xNMS3_Forward, yNMS3_Forward] = non_max_supress(gradientMagnitudeH_Forward, 3, 3);
[NMS3_H_Prewitt, xNMS3_Prewitt, yNMS3_Prewitt] = non_max_supress(gradientMagnitudeH_Prewitt, 3, 3);
[NMS3_H_Sobel, xNMS3_Sobel, yNMS3_Sobel] = non_max_supress(gradientMagnitudeH_Sobel, 3, 3);

[NMS7_H_Central, xNMS7_Central, yNMS7_Central] = non_max_supress(gradientMagnitudeH_Central, 7, 7);
[NMS7_H_Forward, xNMS7_Forward, yNMS7_Forward] = non_max_supress(gradientMagnitudeH_Forward, 7, 7);
[NMS7_H_Prewitt, xNMS7_Prewitt, yNMS7_Prewitt] = non_max_supress(gradientMagnitudeH_Prewitt, 7, 7);
[NMS7_H_Sobel, xNMS7_Sobel, yNMS7_Sobel] = non_max_supress(gradientMagnitudeH_Sobel, 7, 7);

[NMS37_H_Central, xNMS37_Central, yNMS37_Central] = non_max_supress(gradientMagnitudeH_Central, 3, 7);
[NMS37_H_Forward, xNMS37_Forward, yNMS37_Forward] = non_max_supress(gradientMagnitudeH_Forward, 3, 7);
[NMS37_H_Prewitt, xNMS37_Prewitt, yNMS37_Prewitt] = non_max_supress(gradientMagnitudeH_Prewitt, 3, 7);
[NMS37_H_Sobel, xNMS37_Sobel, yNMS37_Sobel] = non_max_supress(gradientMagnitudeH_Sobel, 3, 7);

%% NMS Plots
figure;
sgtitle('Non Maxima Suppression - Healthy Subject - Central Filter - Window 3x3');
subplot(221); imshow(gradientMagnitudeH_Central(1900:2200, 1700:2000), []); title('Orignial Gradient Magnitude');
subplot(222); imshow(xNMS3_Central(1900:2200, 1700:2000), []); title('x NMS');
subplot(223); imshow(yNMS3_Central(1900:2200, 1700:2000), []); title('y NMS');
subplot(224); imshow(NMS3_H_Central(1900:2200, 1700:2000), []); title('NMS');

figure;
sgtitle('Non Maxima Suppression - Healthy Subject - Prewitt Filter - Window 7x7');
subplot(221); imshow(gradientMagnitudeH_Prewitt(1900:2200, 1700:2000), []); title('Orignial Gradient Magnitude');
subplot(222); imshow(xNMS7_Prewitt(1900:2200, 1700:2000), []); title('x NMS');
subplot(223); imshow(yNMS7_Prewitt(1900:2200, 1700:2000), []); title('y NMS');
subplot(224); imshow(NMS7_H_Prewitt(1900:2200, 1700:2000), []); title('NMS');

figure;
sgtitle('Non Maxima Suppression - Healthy Subject - Sobel Filter - Window 3x7');
subplot(221); imshow(gradientMagnitudeH_Sobel(1900:2200, 1700:2000), []); title('Orignial Gradient Magnitude');
subplot(222); imshow(xNMS37_Sobel(1900:2200, 1700:2000), []); title('x NMS');
subplot(223); imshow(yNMS37_Sobel(1900:2200, 1700:2000), []); title('y NMS');
subplot(224); imshow(NMS37_H_Sobel(1900:2200, 1700:2000), []); title('NMS');

figure;
sgtitle('Comparison of NMS Window Sizes');
subplot(221); imshow(gradientMagnitudeH_Sobel(1900:2200, 1700:2000), []); title('Orignial Gradient Magnitude');
subplot(222); imshow(NMS3_H_Sobel(1900:2200, 1700:2000), []); title('Window = 3x3');
subplot(223); imshow(NMS7_H_Sobel(1900:2200, 1700:2000), []); title('Window = 7x7');
subplot(224); imshow(NMS37_H_Sobel(1900:2200, 1700:2000), []); title('Window = 3x7');

%% Threshold

thresh_Central = threshold(NMS7_H_Central, 2.6);
thresh_Forward = threshold(NMS7_H_Forward, 2);
thresh_Prewitt = threshold(NMS7_H_Prewitt, 10);
thresh_Sobel = threshold(NMS7_H_Sobel, 0.04);
thresh_Sobel2 = threshold(NMS7_H_Sobel, 0.2);
thresh_Sobel3 = threshold(NMS7_H_Sobel, 0.0001);

%% Plot Threshold
figure;
sgtitle('Threshold Comparison');
subplot(131); imshow(thresh_Sobel3(1900:2200, 1700:2000), []); title('Threshold = 0.25');
subplot(132); imshow(thresh_Sobel(1900:2200, 1700:2000), []); title('Threshold = 0.5');
subplot(133); imshow(thresh_Sobel2(1900:2200, 1700:2000), []); title('Threshold = 0.75');

%%
figure;
sgtitle('Healthy')
subplot(441); imshow(gradientMagnitudeH_Central(1900:2200,1700:2000), []); title('Gradient - Central Derivative Filter');
subplot(442); imshow(gradientMagnitudeH_Forward(1900:2200,1700:2000), []); title('Gradient - Forward Derivative Filter');
subplot(443); imshow(gradientMagnitudeH_Prewitt(1900:2200, 1700:2000), []); title('Gradient - Prewitt Derivative Filter');
subplot(444); imshow(gradientMagnitudeH_Sobel(1900:2200, 1700:2000), []); title('Gradient - Sobel Derivative Filter');

subplot(445); imshow(NMS3_H_Central(1900:2200,1700:2000), []); title('NMS 3 - Central Derivative Filter');
subplot(446); imshow(NMS3_H_Forward(1900:2200,1700:2000), []); title('NMS 3 - Forward Derivative Filter');
subplot(447); imshow(NMS3_H_Prewitt(1900:2200,1700:2000), []); title('NMS 3 - Prewitt Derivative Filter');
subplot(448); imshow(NMS3_H_Sobel(1900:2200,1700:2000), []); title('NMS 3 - Sobel Derivative Filter');

subplot(449); imshow(NMS7_H_Central(1900:2200,1700:2000), []); title('NMS 7 - Central Derivative Filter');
subplot(4,4,10); imshow(NMS7_H_Forward(1900:2200,1700:2000), []); title('NMS 7 - Forward Derivative Filter');
subplot(4,4,11); imshow(NMS7_H_Prewitt(1900:2200,1700:2000), []); title('NMS 7 - Prewitt Derivative Filter');
subplot(4,4,12); imshow(NMS7_H_Sobel(1900:2200,1700:2000), []); title('NMS 7 - Sobel Derivative Filter');

subplot(4, 4, 13); imshow(thresh_Central(1900:2200,1700:2000), []); title('Threshold - Central Derivative Filter');
subplot(4, 4, 14); imshow(thresh_Forward(1900:2200,1700:2000), []); title('Threshold - Forward Derivative Filter');
subplot(4, 4, 15); imshow(thresh_Prewitt(1900:2200,1700:2000), []); title('Threshold - Prewitt Derivative Filter');
subplot(4, 4, 16); imshow(thresh_Sobel(1900:2200,1700:2000), []); title('Threshold - Sobel Derivative Filter');

%%
figure;
subplot(141); imshow(NMS7_H_Central(1000:1600, 1500:2100), []); title('NMS 7 - Central Derivative Filter');
subplot(142); imshow(NMS7_H_Forward(1000:1600, 1500:2100), []); title('NMS 7 - Forward Derivative Filter');
subplot(143); imshow(NMS7_H_Prewitt(1000:1600, 1500:2100), []); title('NMS 7 - Prewitt Derivative Filter');
subplot(144); imshow(NMS7_H_Sobel(1000:1600, 1500:2100), []); title('NMS 7 - Sobel Derivative Filter');
%% Segmentation
% thresh values --> healthy = 0.04, glaucoma = 0.015, dr = 0.02
threshVal = 0.02;
imgPath = '03_dr.JPG';
GTpath = '03_dr.tif';
img = imread(imgPath);


filter = [1 4 7 4 1;
    4 20 33 20 4;
    7 33 55 33 7;
    4 20 33 20 4;
    1 4 7 4 1];

filter = filter./sum(sum(filter));

imgFilt = spatial_filter(img, filter);

[xGrad, yGrad, magGrad] = derivativeFilterPlot(imgFilt, 'Sobel', 'Healthy');

gradMagFilt = spatial_filter(magGrad, filter);

[NMS, xNMS, yNMS] = non_max_supress(gradMagFilt, 3, 7);

thresh = threshold(NMS, threshVal);
connect = connectNN(thresh);
seg = imfill(connect);
seg = imfill(seg);

GT = imread(GTpath);

x = reshape(GT, [1, numel(GT)]);
y = reshape(seg, [1, numel(seg)]);

intersection = sum(double(x).*y);
DSC = (2*intersection + 1)/(sum(x) + sum(y) + 1);

figure;
sgtitle('Diabetic Retinopathy');
subplot(321);
imshow(rgb2gray(img), []); title('Input image');

subplot(322);
imshow(magGrad(1900:2200, 1700:2000), []); title('Gradient magnitude with gaussian filter');

subplot(323);
imshow(NMS(1900:2200, 1700:2000), []); title('Non maximum suppression');

subplot(324);
imshow(thresh(1900:2200, 1700:2000), []); title('Thresh');

subplot(325)
imshow(seg, []); title('Segmentation');

subplot(326);
imshow(GT, []); title('Ground Truth');

