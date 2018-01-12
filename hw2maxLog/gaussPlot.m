function [Gauss_FG, Gauss_BG] = gaussPlot(n, TrainsampleDCT_BG, TrainsampleDCT_FG, Gauss_FG, Gauss_BG)
for i = n : n + 15
    %var_BG = var(TrainsampleDCT_BG(:,i));
    X = TrainsampleDCT_BG(:,i);
    var_BG = sqrt(sum((X-mean(X)).^2)/length(X)); 
    mean_BG = mean(TrainsampleDCT_BG(:,i));
    Gauss_BG(1, i) = mean_BG;
    Gauss_BG(2, i) = var_BG;

    
    
    Y = TrainsampleDCT_FG(:,i);
    var_FG = sqrt(sum((Y-mean(Y)).^2)/length(Y));

    %var_FG = var(TrainsampleDCT_FG(:,i));
    mean_FG = mean(TrainsampleDCT_FG(:,i));
    Gauss_FG(1, i) = mean_FG;
    Gauss_FG(2, i) = var_FG;

    x_BG = [mean_BG - 4* var_BG :.00001: mean_BG + 4* var_BG];
    normBG = normpdf(x_BG, mean_BG, var_BG);

    x_FG = [mean_FG - 4 * var_FG :.00001: mean_FG + 4* var_FG];
    normFG = normpdf(x_FG, mean_FG, var_FG);
    
    k = mod(i, 16);
    if k ~= 0
        subplot(4, 4, k);
    else
        subplot(4, 4, 16);
    end
    plot(x_BG, normBG, 'b');
    hold on;
    plot(x_FG, normFG, 'r');
    title(['DCT Index ' num2str(i)]);
    xlabel(['DCT Value ']);
    ylabel(['Density']);
    legend('BG','FG');

    hold off;
end
