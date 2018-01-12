%0. load training data and prepared data
load('TrainingSamplesDCT_8.mat');
zig = dlmread('Zig-Zag Pattern.txt');
zig = zig + 1;

%(a)+ (b) Compute prior probability and class condition probability
priorF = 250/1303;
priorG = 1053/1303;

index_BG = index(TrainsampleDCT_BG);
index_FG = index(TrainsampleDCT_FG);
probBG = probFeature(index_BG);
probFG = probFeature(index_FG);
figure, histogram(index_BG);
title('index histogram Grass(FG) PX|Y(grass)')

figure, histogram(index_FG);
title('index histogram Cheetah(FG)  PX|Y(cheetah)')


%(c) read picutre and use DCT by sliding window to reconsturt the feature
%matrix
img = imread('cheetah.bmp');
img = im2double(img);

[row, col] = size(img);
[X, imgX] = featureX(img, zig);
imagesc(X);
colormap(gray(255));


%(d) use BDT to predict the grass and cheetah
newMask = predict(X, probBG, probFG, priorF, priorG);
figure, imshow(img);
figure, imshow(newMask);

mask = imread('cheetah_mask.bmp');
mask = im2double(mask);
diff = mask - newMask;
error = sum(sum(abs(diff))) / (row * col);
errorT = ['the probability of error:', num2str(error)];
disp(errorT);