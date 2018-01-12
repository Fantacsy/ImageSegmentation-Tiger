load('TrainingSamplesDCT_8_new.mat');
data_BG = TrainsampleDCT_BG;
data_FG = TrainsampleDCT_FG;

zig = dlmread('Zig-Zag Pattern.txt');
zig = zig + 1;

num_cluster = 1;

[mu_BG, sigma_BG, p_BG, data_BG] = em(data_BG, 2, num_cluster);
[mu_FG, sigma_FG, p_FG, data_FG] = em(data_FG, 2, num_cluster);

img = imread('cheetah.bmp');
img = im2double(img);
[row, col] = size(img);

newMask = featureX(data_FG, data_BG, img, zig, sigma_BG, mu_BG, p_BG, sigma_FG, mu_FG, p_FG, num_cluster);
mask = imread('cheetah_mask.bmp');
mask = im2double(mask);
diff = mask - newMask;
error = sum(sum(abs(diff))) / (row * col);
        %errorT = ['the probability of error for em method with parameter C= ', int2str(C(i)), ' and dim = ', int2str(dim(j))', ' with error = is: ' num2str(error)];
errorT = ['the probability of error for em method with parameter C= ', int2str(C(i)), ' with error = is: ' num2str(error)];