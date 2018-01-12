format long

load('TrainingSamplesDCT_subsets_8.mat')
load('Prior_2.mat')
load('Alpha.mat')

zig = dlmread('Zig-Zag Pattern.txt');
zig = zig + 1;

error_vector_map = [];
for i = 1 : length(alpha)
    W = alpha(i) * W0;
    [~, mu_n_BG, ~, sigma_BG] = bayesian(D4_BG, mu0_BG, W);
    [~, mu_n_FG, ~, sigma_FG] = bayesian(D4_FG, mu0_FG, W);

    img = imread('cheetah.bmp');
    img = im2double(img);
    [row, col] = size(img);

    newMask = featureX(D4_FG, D4_BG, img, zig, sigma_BG, mu_n_BG, sigma_FG, mu_n_FG);
    
    if i == 1
        figure, imshow(newMask);
        title(['the probability of error for MAP method when alpha = ', num2str(alpha(i))]);
    end
    
    mask = imread('cheetah_mask.bmp');
    mask = im2double(mask);
    diff = mask - newMask;
    error = sum(sum(abs(diff))) / (row * col);
    error_vector_map = [error_vector_map, error];
    errorT = ['the probability of error for MAP method when alpha = ', num2str(alpha(i)), ' is: ' num2str(error)];
    disp(errorT);
end
disp(error_vector_map);