function [x]  = index(testData)
[row, col] = size(testData);
for i = 1 : row
    x(i) = 2;
    max = testData(i,2);
    for j = 2 : col
        if (testData(i,j) > max)
            max = testData(i, j);
            x(i) = j;
        end
    end
end
end
