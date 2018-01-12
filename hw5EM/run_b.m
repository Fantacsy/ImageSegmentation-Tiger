load('TrainingSamplesDCT_8_new.mat');
data_BG = TrainsampleDCT_BG;
data_FG = TrainsampleDCT_FG;

zig = dlmread('Zig-Zag Pattern.txt');
zig = zig + 1;

dim = [1 2 4 8 16 24 32 40 48 56 64];
C = [1 2 4 8 16 32];

errorMatrix = zeros(length(C), length(dim));


for i= 1 : length(C)
    for j = 1 : length(dim)
        [mu_BG, sigma_BG, p_BG] = em(data_BG, dim(j), C(i));
        [mu_FG, sigma_FG, p_FG] = em(data_FG, dim(j), C(i));

        img = imread('cheetah.bmp');
        img = im2double(img);
        [row, col] = size(img);

        newMask = featureX(data_FG, data_BG, img, zig, sigma_BG, mu_BG, p_BG, sigma_FG, mu_FG, p_FG, C(i));
        if(i == 1 && j ==1)
            figure, imshow(newMask);
        end
        mask = imread('cheetah_mask.bmp');
        mask = im2double(mask);
        diff = mask - newMask;
        error = sum(sum(abs(diff))) / (row * col);
        %errorT = ['the probability of error for em method with parameter C= ', int2str(C(i)), ' and dim = ', int2str(dim(j))', ' with error = is: ' num2str(error)];
        errorT = ['the probability of error for em method with parameter C= ', int2str(C(i)), ' with error = is: ' num2str(error)];

        disp(errorT);
        errorMatrix(i, j) = error;
    end
end

error_1 = errorMatrix(1, :);
error_2 = errorMatrix(2, :);
error_3 = errorMatrix(3, :);

error_4 = errorMatrix(4, :);
error_5 = errorMatrix(5, :);
error_6 = errorMatrix(6, :);

plot(dim, error_1, '+-', dim, error_2, '*-', dim, error_3, '+-', dim, error_4, '*-',dim, error_5, '+-', dim, error_6, '*-');
title(['dimension vs POE']);
xlabel(['dimension ']);
ylabel(['Probability of Error']);
legend('C = 1','C = 2', 'C = 4','C = 8','C = 16', 'C = 32');


