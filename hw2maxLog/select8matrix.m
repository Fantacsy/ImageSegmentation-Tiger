function X = select8matrix(matrix, select)

[row, col] = size(matrix);
j = 1;
for i = 1 : col
    if (i == select(j))
        X(:, j) = matrix(:, i);
        j = j + 1;
        if(j == 9)
            break;
        end
    end
end
end