function newImage = predict(X, probBG, probFG, priorF, priorG)
[row, col] = size(X);
for i = 1 : row
    for j = 1 : col
        predictFG = probFG(X(i, j)) * priorF;
        predictBG = probBG(X(i, j)) * priorG;
        if(predictFG >= predictBG)
            newImage(i, j) = 1;
        else
            newImage(i, j) = 0;
        end
    end
end
