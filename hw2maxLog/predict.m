function x = predict(dctValue, Gauss_FG, Gauss_BG, sigma_FG, sigma_BG)

priorF = 250/1303;
priorG = 1053/1303;

voteFG = -1/2 * (dctValue - Gauss_FG(1,:)) * inv(sigma_FG) * (dctValue - Gauss_FG(1,:))'  - log( det(sigma_FG))/2 + log(priorF);
voteBG = -1/2 * (dctValue - Gauss_BG(1,:)) * inv(sigma_BG) * (dctValue - Gauss_BG(1,:))'  - log( det(sigma_BG))/2 + log(priorG);


if(voteFG > voteBG)
    x = 1;
else
    x = 0;
end


end
