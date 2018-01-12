function [x_avg, mu_n, sigma_n, sigma] = bayesian(data, mu0, W0)

[data_size, ~] = size(data);
x_avg = mean(data);

mu_0 = mu0';
sigma_0 = diag(W0);
sigma = zeros(64, 64);
for i = 1 : data_size
    sigma = sigma + ((data(i,:) - x_avg)' * (data(i,:) - x_avg))/data_size;
end

mu_n = sigma_0 * inv(sigma_0 + sigma / data_size) * x_avg' + 1/data_size * sigma * inv(sigma_0 + sigma/data_size) * mu_0;
sigma_n = sigma_0 * inv(sigma_0 + sigma/data_size) * (1/data_size) * sigma;
x_avg = x_avg';