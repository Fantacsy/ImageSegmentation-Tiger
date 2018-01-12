function ppplot(errorMatrix)

dim = [1 2 4 8 16 24 32 40 48 56 64];

error_1 = errorMatrix(1, :);
error_2 = errorMatrix(2, :);
error_3 = errorMatrix(3, :);

error_4 = errorMatrix(4, :);
error_5 = errorMatrix(5, :);
%plot(dim, error_1)

plot(dim, error_1, '+-', dim, error_2, '*-', dim, error_3, '+-', dim, error_4, '*-',dim, error_5, '+-');
title(['dimension vs POE']);
xlabel(['dimension ']);
ylabel(['Probability of Error']);
legend('BG = 1','BG = 2', 'BG = 3','BG = 4','BG = 5');
set(gca,'fontsize', 24);
