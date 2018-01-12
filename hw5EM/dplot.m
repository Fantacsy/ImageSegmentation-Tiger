function dplot(errorMatrix)

dim = [1 2 4 8 16 24 32 40 48 56 64];

error_1 = errorMatrix(1, :);
error_2 = errorMatrix(2, :);
error_3 = errorMatrix(3, :);

error_4 = errorMatrix(4, :);
error_5 = errorMatrix(5, :);
error_6 = errorMatrix(6, :);
%plot(dim, error_1)

plot(dim, error_1, '+-', dim, error_2, '*-', dim, error_3, '+-', dim, error_4, '*-',dim, error_5, '+-', dim, error_6, '*-');
title(['dimension vs POE']);
xlabel(['dimension ']);
ylabel(['Probability of Error']);
legend('C = 1','C = 2', 'C = 4','C = 8','C = 16', 'C = 32');
set(gca,'fontsize', 24);
