function sigma = sigmaML(data, mean)

[row, col] = size(data);
sigma = zeros(col, col);

for i = 1 : row
    sigma = sigma + (data(i,:) - mean)' * (data(i, :) - mean)/row;
end
end