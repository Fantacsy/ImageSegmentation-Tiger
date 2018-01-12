function [X, imgX] = featureX(img, zig)
[row, col] = size(img);


zero1 = zeros(3, 7 + col);
zero2 = zeros(row, 3);
zero3 = zeros(row, 4);
zero4 = zeros(4, 7 + col);



%zero1 = zeros(row, 7);
%zero2 = zeros(7, col);
%zero3 = zeros(7, 7);
%imgX = [img zero1; zero2 zero3];

imgX = [zero1; zero2 img zero3; zero4];
[newRow, newCol] = size(imgX);



for i = 4 : newRow - 4
    for j = 4 : newCol - 4
        sliding = imgX(i - 3: i+4, j - 3 : j + 4);
        sliding = abs(dct2(sliding));
        for l  = 1 : 8
            for m = 1 : 8    
                dctValue(zig(l, m)) = sliding(l, m); 
            end    
        end
        dctValue(1) = 0;
        for k = 2 : 64
            if(dctValue(k) == max(dctValue))
                X(i - 3, j - 3) = k;
            end
        end
    end
end
