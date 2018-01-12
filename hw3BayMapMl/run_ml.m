format long

load('TrainingSamplesDCT_subsets_8.mat')
load('Prior_2.mat')
load('Alpha.mat')

zig = dlmread('Zig-Zag Pattern.txt');
zig = zig + 1;

W = alpha(9) * W0;
[mu_BG, mu_n_BG, sigma_n_BG, sigma_BG] = bayesian(D4_BG, mu0_BG, W);
[mu_FG, mu_n_FG, sigma_n_FG, sigma_FG] = bayesian(D4_FG, mu0_FG, W);

img = imread('cheetah.bmp');
img = im2double(img);
[row, col] = size(img);

newMask = featureX(D4_FG, D4_BG, img, zig, sigma_BG, mu_BG, sigma_FG, mu_FG);
figure, imshow(newMask);
title(['graph segmentation by ML method: ']);
mask = imread('cheetah_mask.bmp');
mask = im2double(mask);
diff = mask - newMask;
error = sum(sum(abs(diff))) / (row * col);
errorT = ['the probability of error for ML method: ', num2str(error)];
disp(errorT);
error_vector_ml = error * ones(1, length(alpha));