function probIndex = probFeature(index)
probIndex = zeros(1, 64);
[x, y] = size(index);
for i = 1 : y
    probIndex(index(i)) = probIndex(index(i)) + 1;
end
probIndex = probIndex / y;