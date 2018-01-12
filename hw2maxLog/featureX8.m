function X = featureX8(img, zig, Gauss_FG, Gauss_BG, TrainsampleDCT_FG, TrainsampleDCT_BG, select)


TrainsampleDCT_FG8 = select8matrix(TrainsampleDCT_FG, select);
TrainsampleDCT_BG8 = select8matrix(TrainsampleDCT_BG, select);

Gauss_FG8 = select8matrix(Gauss_FG, select);
Gauss_BG8 = select8matrix(Gauss_BG, select);

sigma_FG8 = sigmaML(TrainsampleDCT_FG8, Gauss_FG8(1,:));
sigma_BG8 = sigmaML(TrainsampleDCT_BG8, Gauss_BG8(1,:));

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
        dctValue8 = select8matrix(dctValue, select);
        X(i - 3, j - 3) = predict(dctValue8, Gauss_FG8, Gauss_BG8, sigma_FG8, sigma_BG8);
    end
end


