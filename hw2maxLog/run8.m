%select the best 8 features by visual inspection
select = [1 7 10 14 17 18 19 40];
newMask8 = featureX8(img, zig, Gauss_FG, Gauss_BG, TrainsampleDCT_FG, TrainsampleDCT_BG, select);
figure, imshow(newMask8);
title(['mask 8 features selection ']);
diff8 = mask - newMask8;
error8 = sum(sum(abs(diff8))) / (row * col);
errorT8 = ['the probability of error for 8 features selection:', num2str(error8)];
disp(errorT8);