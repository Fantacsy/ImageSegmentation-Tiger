semilogx(alpha, error_vector_bay,'+-', alpha, error_vector_map,'*-', alpha, error_vector_ml, 'o-')

title(['alpha vs POE']);
xlabel(['Alpha Value ']);
ylabel(['Probability of Error']);
legend('Bayesian','MAP', 'ML');
