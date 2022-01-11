%% BME 872 
% Lab 1 - Medical Image Management, Histograms & Point Operations
% Andrew Mullen, Spencer Carrick
close all;
clear all;
clc;

%% Medical Image Management
%dataPath = input('Enter the path to the data\n', 's');
dataPath = 'Lab1 - BrainMRI1/';

addpath(genpath(dataPath));
addpath(genpath('Lab1 - BrainMRI2/'));
addpath(genpath('Lab1 - LungCT'));

files = dir(dataPath);
files(1:2) = []

for i = 1:length(files)
    
    disp(files(i).name)
    imageFormat= files(i).name(length(files(i).name)-2:length(files(i).name));
    imagePath = strcat(dataPath, files(i).name);
    [img, info] = imageRead(imagePath, imageFormat);
   
end

%% 2.1.1 Medical Image Loading and Viewing
% a.) Lung CT image
% Load Image
%dataPath = input('Enter the path to the data\n', 's');
dataPath = 'Lab1/Lab1 - LungCT/training_post.mhd';
addpath(genpath(dataPath));

imageFormat= 'mhd';

[volCT, infoCT] = imageRead(dataPath, imageFormat);

% Plot one from the middle
image = volCT(:,:,143);
figure;
imshow(image, []);
colorbar
title('Training Post Lung CT - Slice 143')

%% b.) Brain MRI1 image
% Load Image
%dataPath = input('Enter the path to the data\n', 's');
dataPath = 'Lab1 - BrainMRI1/';
addpath(genpath(dataPath));
files = dir(dataPath);
files(1:2) = [];

imageFormat = 'dcm';

for i = 1:length(files) 
    
    slicePath = strcat(dataPath, files(i).name);
    [volBrain(:,:,i), infoBrain] = imageRead(slicePath, imageFormat);
end

% Plot Image
brainSlice = volBrain(:,:,18);
figure;
imshow(brainSlice, []);
colorbar
title('Brain MRI1 - Slice 18')

%% c.) Plot all Brain slices on one figure
figure;
sgtitle('Brain MRI 1')
for i = 1:size(volBrain, 3)
    
    subplot(4, 5, i);
    imshow(volBrain(:,:,i), []);
    text = 'Slice # ' + string(i);
    title(text)

end    
    
%% 2 a.) Medical Image Writing
% Single volCT image saved as .png
imageCT = volCT(:,:,183);
name = 'sliceCT_183';
type = 'png';

% Save
imageWrite(uint16(image), name, type);

% Read Image Back in
[imgCT_PNG, ~] = imageRead(strcat(name, '.png'), 'png');
    
figure;
subplot(1,2,1)
imshow(imageCT, []);
colorbar
title('Original CT image');

subplot(1,2,2)
imshow(imgCT_PNG, []);
colorbar
title('PNG CT image');
    
%% 2.2 Intensity Histograms    
% Image + Histogram for CT
[bin, ~, freq] = intensityHistogram(imageCT, 500);

figure;
subplot(1,2,1)
imshow(imageCT, [])
colorbar
title('Slice # 143 of Lung CT')

subplot(1,2,2)
bar(bin, freq);
xlabel('Bin Value'); ylabel('Number of Occurences');
title('Image Histogram');

% Image + Histogram for Brain MRI
[bin, ~, freq] = intensityHistogram(brainSlice, 500);

figure;
subplot(1,2,1)
imshow(brainSlice, [])
colorbar
title('Slice # 18 of Brain MRI')

subplot(1,2,2)
bar(bin(2:500), freq(2:500));
xlabel('Bin Value'); ylabel('Number of Occurences');
title('Image Histogram');

%% Volume Histograms    
[bin, freq, nfreq] = intensityHistogram(volCT, 500);
figure;
subplot(121);
bar(bin, freq);
xlabel('Bin Value'); ylabel('Number of Occurences');
title('Lung CT Volume Histogram');

subplot(122);
bar(bin, nfreq);
xlabel('Bin Value'); ylabel('Number of Occurences');
title('Normalized Lung CT Volume Histogram');

[bin, freq, nfreq] = intensityHistogram(volBrain, 500);
figure;
subplot(121);
bar(bin(2:500), freq(2:500));
xlabel('Bin Value'); ylabel('Number of Occurences');
title('Brain MRI Volume Histogram');

subplot(122);
bar(bin(2:500), nfreq(2:500));
xlabel('Bin Value'); ylabel('Number of Occurences');
title('Normalized Brain MRI volume Histogram');

%% 2.3 Point Operations
% Intensity Scaling and Shifting
brain12 = imageRead('brain_012.dcm', 'dcm');

C = [-2, 4, 8]; B = [100, 30, -600];

figure;
for i = 1:3
    
    img = apply_point_tfrm(brain12, C(i), B(i));
    [bin, ~, freq] = intensityHistogram(img, 500);
    
    subplot(3,2,2*i-1)
    imshow(img,[]);
    colorbar
    titleText = 'Brain 012 Image with C=' + string(C(i)) + ' and B='+ string(B(i));
    title(titleText)
    
    subplot(3,2,2*i)
    bar(bin, freq);
    xlabel('Bin Value'); ylabel('Number of Occurences');
    title('Histogram');
    ylim([0 0.05]);
        
end

%% Image Masking and Overlays
[postVol, postInfo] = imageRead('Lab1 - LungCT/training_post.mhd', 'mhd');
[maskVol, maskInfo] = imageRead('Lab1 - LungCT/training_mask.mhd', 'mhd');

img = postVol(:,:,143);
mask = maskVol(:,:,143);

img = normalize(img);
img = img - min(min(img));
mask = normalize(mask);

output = apply_mask(img, mask);

figure;
subplot(131);
imshow(img, []);
colorbar;
title('Original Image');

subplot(132);
imshow(mask, []);
colorbar
title('Mask');

subplot(133);
imshow(output, []);
title('Masked Image');
colorbar

%% Plot histogram for Images
[imgBin, ~, imgFreq] = intensityHistogram(img, 500);
[maskBin, ~, maskFreq] = intensityHistogram(mask, 500);
[outBin, ~, outFreq] = intensityHistogram(output, 500);

figure;
subplot(131); bar(imgBin, imgFreq); title('Image Histogram');
xlabel('Bin Value'); ylabel('Number of Occurences');
xlim([0 1.5]);

subplot(132); bar(maskBin(2:500), maskFreq(2:500)); title('Mask Histogram');
xlabel('Bin Value'); ylabel('Number of Occurences');
xlim([0 1.5]);

subplot(133); bar(outBin(2:500), outFreq(2:500)); title('Masked Image Histogram');
xlabel('Bin Value'); ylabel('Number of Occurences');
xlim([0 1.5]);

%% Overlay
figure;
subplot(131); overlayImg(img, mask, [0 0 1], 0.9); title('Blue Overlay');
subplot(132); overlayImg(img, mask, [1 0 0], 0.2); title('Red Overlay');
subplot(133); overlayImg(img, mask, [0 1 0], 0.5); title('Green Overlay');

%% Image Subtraction
[pre, infoPre] = imageRead('Lab1 - LungCT/training_pre19mm.mhd', 'mhd');
[post, infoPost] = imageRead('Lab1 - LungCT/training_post.mhd', 'mhd');

post1 = post(:,:,143); post2 = post(:,:,100); post3 = post(:,:,200);
pre1 = pre(:,:,143); pre2 = pre(:,:,100); pre3 = pre(:,:,200);


out1 = imageSubtraction(pre1, post1);
out2 = imageSubtraction(pre2, post2);
out3 = imageSubtraction(pre3, post3);

figure;
tempLims = [min(min(out1)) max(max(out1))];
subplot(131); imagesc(pre1); title('Pre Contrast Slice #143'); colormap(gray);
subplot(132); imagesc(post1); title('Post Contrast Slice #143'); colormap(gray);
subplot(133); imagesc(out1, tempLims); title('Perfusion Result Slice #143');colormap(gray); colorbar;

figure;
tempLims = [min(min(out2)) max(max(out2))];
subplot(131); imagesc(pre2); title('Pre Contrast Slice #100'); colormap(gray);
subplot(132); imagesc(post2); title('Post Contrast Slice #100'); colormap(gray);
subplot(133); imagesc(out2, tempLims); title('Perfusion Result Slice #100');colormap(gray); colorbar;

figure;
tempLims = [min(min(out3)) max(max(out3))];
subplot(131); imagesc(pre3); title('Pre Contrast Slice #200'); colormap(gray);
subplot(132); imagesc(post3); title('Post Contrast Slice #200'); colormap(gray);
subplot(133); imagesc(out3, tempLims); title('Perfusion Result Slice #200');colormap(gray); colorbar;

%% 3b.
mask1 = maskVol(:,:,143); mask2 = maskVol(:,:,100); mask3 = maskVol(:,:,200);
img1 = postVol(:,:,143); img2 = postVol(:,:,100); img3 = maskVol(:,:,200);

maskPerfusion1 = apply_mask(normalize(out1), mask1);
maskPerfusion2 = apply_mask(normalize(out2), mask2);
maskPerfusion3 = apply_mask(normalize(out3), mask3);

figure;
tempLims = [min(min(maskPerfusion1)) max(max(maskPerfusion1))];
subplot(141); imagesc(pre1); title('Pre Contrast Slice #143'); colormap(gray);
subplot(142); imagesc(post1); title('Post Contrast Slice #143'); colormap(gray);
subplot(143); imagesc(normalize(maskPerfusion1), [0 1]); title('Masked Perfusion Result Slice #143');colormap(gray);
subplot(144); overlayImg(normalize(img1), normalize(maskPerfusion1), [0 0 1], 1); 
title('Perfusion overlayed original image Slice #143');


figure;
tempLims = [min(min(maskPerfusion2)) max(max(maskPerfusion2))];
subplot(141); imagesc(pre2); title('Pre Contrast Slice #100'); colormap(gray);
subplot(142); imagesc(post2); title('Post Contrast Slice #100'); colormap(gray);
subplot(143); imagesc(normalize(maskPerfusion2), [0 1]); title('Masked Perfusion Result Slice #100');colormap(gray); colorbar;
subplot(144); overlayImg(normalize(img2), normalize(maskPerfusion2), [0 0 1], 1); 
title('Perfusion overlayed original image Slice #100');


figure;
tempLims = [min(min(maskPerfusion3)) max(max(maskPerfusion3))];
subplot(141); imagesc(pre3); title('Pre Contrast Slice #200'); colormap(gray);
subplot(142); imagesc(post3); title('Post Contrast Slice #200'); colormap(gray);
subplot(143); imagesc(normalize(maskPerfusion3), [0 1]); title('Masked Perfusion Result Slice #200');colormap(gray);
subplot(144); overlayImg(normalize(post3), normalize(maskPerfusion3), [0 0 1], 1); 
title('Perfusion overlayed original image Slice #200');


%% 3c. Image Subtraction with noise
noiseVol = imageRead('Lab1 - LungCT/noise_10x_post.mhd', 'mhd');
noiseImg1 = noiseVol(:,:,143);
noise(:,:) = noiseImg1 - post1;

[pBin, ~, pFreq] = intensityHistogram(post1, 500);
[niBin, ~, niFreq] = intensityHistogram(noiseImg1, 500);
[nBin, ~, nFreq] = intensityHistogram(noise, 500)

%% 
figure;
subplot(231); imagesc(normalize(post1), [0 1]); title('Slice 143 of post volume'); colormap('gray');
subplot(232); imagesc(normalize(noiseImg1), [0 1]); title('Slice 143 of noise volume'); colormap('gray');
subplot(233); imagesc(normalize(noise), [0 1]); title('Image Subtraction of Noise and Post'); colormap('gray');
subplot(234); bar(pBin, pFreq); title('Post image Histogram'); xlabel('Bin Value'); ylabel('Number of Occurences');
subplot(235); bar(niBin, niFreq); title('Noise Image Histogram'); xlabel('Bin Value'); ylabel('Number of Occurences');
subplot(236); bar(nBin, nFreq); title('Noise Histogram'); xlabel('Bin Value'); ylabel('Number of Occurences');

%% Average Images
brain = imageRead('Lab1 - BrainMRI2/brainMRI_5.mat', 'mat');
output = avg_img(brain);
[bin, ~, nfreq] = intensityHistogram(brain, 500);
[bin100, ~, nfreq100] = intensityHistogram(brain(:,:,100), 500);
[bin50, ~, nfreq50] = intensityHistogram(brain(:,:,50), 500);
[bin150, ~, nfreq150] = intensityHistogram(brain(:,:,150), 500);

figure;
subplot(241);
imagesc(brain(:,:,50)); title('Brain 5 - Slice #50');
subplot(242)
bar(bin50, nfreq50); title('Slice 50 Histogram'); xlabel('Bin Value'); ylabel('Number of Occurences');

subplot(243);
imagesc(brain(:,:,100)); title('Brain 5 - Slice #100');
subplot(244)
bar(bin100, nfreq100); title('Slice 100 Histogram'); xlabel('Bin Value'); ylabel('Number of Occurences');

subplot(245);
imagesc(brain(:,:,150)); title('Brain 5 - Slice #150');
subplot(246)
bar(bin150, nfreq150); title('Slice 150 Histogram'); xlabel('Bin Value'); ylabel('Number of Occurences');

subplot(247);
imagesc(output); colormap(gray);
title('Synchronized Average - Brain #5');

subplot(248); bar(bin, nfreq); title('Synchronized Average Histogram');
xlabel('Bin Value'); ylabel('Number of Occurences'); ylim([0 0.02])






