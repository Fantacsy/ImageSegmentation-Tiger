function X = featureX(img, zig, Gauss_FG, Gauss_BG, sigma_FG, sigma_BG)
[row, col] = size(img);


zero1 = ones(3, 7 + col)/2;
zero2 = ones(row, 3)/2;
zero3 = ones(row, 4)/2;
zero4 = ones(4, 7 + col)/2;

%zero1 = zeros(row, 7);
%zero2 = zeros(7, col);
%zero3 = zeros(7, 7);
%imgX = [img zero1; zero2 zero3];

imgX = [zero1; zero2 img zero3; zero4];
[newRow, newCol] = size(imgX);



for i = 4 : newRow - 4
    for j = 4 : newCol - 4
        sliding = imgX(i - 3: i+4, j - 3 : j + 4);
        sliding = dct2(sliding);
        for l  = 1 : 8
            for m = 1 : 8    
                dctValue(zig(l, m)) = sliding(l, m); 
            end    
        end
        
        X(i - 3, j - 3) = predict(dctValue, Gauss_FG, Gauss_BG, sigma_FG, sigma_BG);
    end
end