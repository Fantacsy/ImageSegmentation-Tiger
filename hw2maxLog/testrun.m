select = [1, 2, 6, 8, 10, 23, 24, 28];
newMask8 = featureX8(img, zig, Gauss_FG, Gauss_BG, TrainsampleDCT_FG, TrainsampleDCT_BG, select);
diff8 = mask - newMask8;
error8 = sum(sum(abs(diff8))) / (row * col);
errorT8 = ['the probability of error for 8 features selection:', num2str(error8)];
disp(errorT8);
