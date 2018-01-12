load('TrainingSamplesDCT_8_new.mat');
zig = dlmread('Zig-Zag Pattern.txt');
zig = zig + 1;

%(a)Compute prior probability and class condition probability
priorF = 250/1303;
priorG = 1053/1303;

%(b) compute the maximum likelihood estimates for the parameters
%of the class conditional densities PX|Y (x|cheetah) and PX|Y (x|grass)
%under the Gaussian assumption.

Gauss_FG = zeros(2, 64);
Gauss_BG = zeros(2, 64);

[Gauss_FG, Gauss_BG] = gaussPlot(1, TrainsampleDCT_BG, TrainsampleDCT_FG, Gauss_FG, Gauss_BG);
figure;
[Gauss_FG, Gauss_BG] = gaussPlot(17, TrainsampleDCT_BG, TrainsampleDCT_FG, Gauss_FG, Gauss_BG);
figure;
[Gauss_FG, Gauss_BG] = gaussPlot(33, TrainsampleDCT_BG, TrainsampleDCT_FG, Gauss_FG, Gauss_BG);
figure;
[Gauss_FG, Gauss_BG] = gaussPlot(49, TrainsampleDCT_BG, TrainsampleDCT_FG, Gauss_FG, Gauss_BG);

sigma_FG = sigmaML(TrainsampleDCT_FG, Gauss_FG(1,:));
sigma_BG = sigmaML(TrainsampleDCT_BG, Gauss_BG(1,:));

%(c) read image and use BDR to classify the cheetah and grass
img = imread('cheetah.bmp');
img = im2double(img);
[row, col] = size(img);

newMask = featureX(img, zig, Gauss_FG, Gauss_BG, sigma_FG, sigma_BG);
figure, imshow(newMask);
title(['mask 64 features selection ']);
mask = imread('cheetah_mask.bmp');
mask = im2double(mask);
diff = mask - newMask;
error = sum(sum(abs(diff))) / (row * col);
errorT = ['the probability of error for 64 features selection:', num2str(error)];
disp(errorT);