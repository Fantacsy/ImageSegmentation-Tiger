function errorMatrix = run_predict_a(mu_FG, sigma_FG, p_FG, mu_BG, sigma_BG, p_BG)

load('TrainingSamplesDCT_8_new.mat');
data_BG = TrainsampleDCT_BG;
data_FG = TrainsampleDCT_FG;

zig = dlmread('Zig-Zag Pattern.txt');
zig = zig + 1;

dimSet = [1 2 4 8 16 24 32 40 48 56 64];
C = 8;

img = imread('cheetah.bmp');
img = im2double(img);
[row, col] = size(img);
mask = imread('cheetah_mask.bmp');
mask = im2double(mask);  

errorMatrix = zeros(5, length(dimSet), 5);


for k = 1 : 5
    for i = 1 : 5
        for j = 1 : length(dimSet)
            data_FG_train = data_FG(:, 1 : dimSet(j));
            sigma_FG_train = sigma_FG(1 : dimSet(j), 1 : dimSet(j),:, :);
            mu_FG_train = mu_FG(:, 1: dimSet(j), :);
       
            data_BG_train = data_BG(:, 1 : dimSet(j));
            sigma_BG_train = sigma_BG(1 : dimSet(j), 1 : dimSet(j),:, :);
            mu_BG_train = mu_BG(:, 1: dimSet(j), :);
       
            
            
            newMask = featureX(data_FG_train, data_BG_train, img, zig, sigma_BG_train(:, :, :, i), mu_BG_train(:, :, i), p_BG(:, :, i), sigma_FG_train(:, :,:, k), mu_FG_train(:, :, k), p_FG(:, :, k), C);
            if(j ==1)
                figure, imshow(newMask); 
            end
            diff = mask - newMask;
            error = sum(sum(abs(diff))) / (row * col);
            errorT = ['the probability of error for em method with parameter dim= ', int2str(dimSet(j)), ' with error = is: ' num2str(error)];
            disp(errorT);
            errorMatrix(i, j, k) = error;
        end
    end
end

errorMatrix

%error_1 = errorMatrix(1, :);
%error_2 = errorMatrix(2, :);
%error_3 = errorMatrix(3, :);

%error_4 = errorMatrix(4, :);
%error_5 = errorMatrix(5, :);
%error_6 = errorMatrix(6, :);

%plot(dim, error_1, '+-', dim, error_2, '*-', dim, error_3, '+-', dim, error_4, '*-',dim, error_5, '+-', dim, error_6, '*-');
%title(['dimension vs POE']);
%xlabel(['dimension ']);
%ylabel(['Probability of Error']);
%legend('C = 1','C = 2', 'C = 4','C = 8','C = 16', 'C = 32');


