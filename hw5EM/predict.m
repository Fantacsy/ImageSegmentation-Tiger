function x = predict(dataF, dataG, dctValue, sigma_BG, mu_BG, p_BG, sigma_FG, mu_FG, p_FG, num_cluster)

[datasizeF, ~] = size(dataF);
[datasizeG, ~] = size(dataG);
featureSize = length(mu_FG(1,:));
%[~, featureSize, ~] = size(sigma_FG);


priorF = datasizeF/(datasizeF + datasizeG);
priorG = datasizeG/(datasizeF + datasizeG);

dctValue = dctValue(1:featureSize);



voteFG = 0;
for i = 1 : num_cluster
    a = dctValue;
    b = mu_FG(i, :);
    c = sigma_FG(:, :, i);
    d = p_FG(i);
    
    voteFG = voteFG + (1/sqrt(2 * pi * det(c))) * exp(-1/2 * (a - b) * inv(c) * (a - b)') * d;
end
voteFG = voteFG * priorF;



voteBG = 0;
for i = 1 : num_cluster
    a = dctValue;
    b = mu_BG(i, :);
    c = sigma_BG(:, :, i);
    d = p_BG(i);
    
    voteBG = voteBG + (1/sqrt(2 * pi * det(c))) * exp(-1/2 * (a - b) * inv(c) * (a - b)') * d;
end
voteBG = voteBG * priorG;


if(voteFG > voteBG)
    x = 1;
else
    x = 0;
end

end
