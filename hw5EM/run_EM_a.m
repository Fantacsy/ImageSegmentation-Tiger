function [mu_FG, sigma_FG, p_FG, mu_BG, sigma_BG, p_BG] = run_EM_a

load('TrainingSamplesDCT_8_new.mat');
data_BG = TrainsampleDCT_BG;
data_FG = TrainsampleDCT_FG;


C = 8;
dim = 64;

mu_FG = zeros(C, dim, 5);
sigma_FG = zeros(dim, dim, C, 5);
p_FG = zeros(1, C, 5);

mu_BG = zeros(C, dim, 5);
sigma_BG = zeros(dim, dim, C, 5);
p_BG = zeros(1, C, 5);


for i = 1 : 5
    [mu, sigma, p] = em_a(data_BG, dim, C);
    
    
    mu_BG(:, :, i) = mu;
    sigma_BG(:, :, :, i) = sigma;
    p_BG(:, :, i) = p;
    
    
    
    [mu, sigma, p] = em_a(data_FG, dim, C);
    mu_FG(:, :, i) = mu;
    sigma_FG(:, :, :, i) = sigma;
    p_FG(:, :, i) = p;
    
    finishEM = ['finish em at step i = ', int2str(i)];
    disp(finishEM);
end