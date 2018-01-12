function x = predict(dataF, dataG, dctValue, sigma_BG, mu_BG, sigma_FG, mu_FG)

[datasizeF, ~] = size(dataF);
[datasizeG, ~] = size(dataG);


priorF = datasizeF/(datasizeF + datasizeG);
priorG = datasizeG/(datasizeF + datasizeG);

%dctValue = dctValue';
%mu_n_FG = mu_n_FG';
%mu_n_BG = mu_n_BG';

%voteFG  = log(normpdf(dctValue, mu_n_FG , sigma_new_FG)) +  log(priorF);
%voteBG  = log(normpdf(dctValue, mu_n_BG , sigma_new_BG)) +  log(priorG);


voteFG = -1/2 * (dctValue - mu_FG') * sigma_FG^(-1) * (dctValue - mu_FG')'  - log( det(sigma_FG))/2 + log(priorF);
voteBG = -1/2 * (dctValue - mu_BG') * sigma_BG^(-1) * (dctValue - mu_BG')'  - log( det(sigma_BG))/2 + log(priorG);

if(voteFG > voteBG)
    x = 1;
else
    x = 0;
end

end
