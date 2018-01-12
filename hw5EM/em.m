function [mu, sigma, p, X] = em(data, dim, num_cluster)

X = data; % 1053x8 data set
N = size(X,1); % number of samples
X = X(1:N, 1:dim);
D = size(X,2); % dim of features
K = num_cluster;

% Initialization
p = rand(1, K);
p = p / sum(p); % arbitrary pi
[idx,mu] = kmeans(X,K); % initial means of the components
% compute the covariance of the components
mu
sigma = zeros(D,D,K);
for k = 1:K
    for i = 1 : D
        sigma(i,i,k) = 2;
    end
end

converged = 0;      %converge flag
prevLoglikelihood = Inf;
prevMu = mu;
prevSigma = sigma;
prevPi = p;
round = 0;
mu;
while (converged ~= 1)
    round = round +1;
    hd = zeros(N,K); % gaussian component in the nominator
    sumhd = zeros(N,1); % denominator of responsibilities
    
    % E-step:  Evaluate the responsibilities using the current parameters
    % compute the nominator and denominator of the responsibilities
    for j = 1:K
        for i = 1:N
            a = X(i, :);
            b = mu(j, :);
            c = sigma(:, :, j);
            d = p(j);
            hd(i,j) = (1/sqrt(2 * pi * det(c))) * exp(-1/2 * (a - b) * inv(c) * (a - b)') * d;
            %sumhd(i) = sumhd(i) + hd(i,j);
        end
    end
    
    for j = 1 : K
        for i = 1 : N
            sumhd(i) = sumhd(i) + hd(i, j);
        end
    end
    % calculate responsibilities
    h = zeros(N,K); % responsibilities
    Nk = zeros(K,1);


    for j = 1:K
        for i = 1:N
            % I tried to use the exp(gm(k,i)/sumGM(i)) to compute res but this leads to sum(pi) > 1.
            h(i,j) = hd(i,j)/sum(hd(i,:));
        end
    end
    
    for j = 1 : K
        Nk(j) = sum(h(:,j));
    end
    
    sigma = zeros(D,D,K);
    mu = zeros(K, D);

    
    %M-step
    for j = 1 : K
        for i = 1 : N
            mu(j,:) = mu(j,:) + h(i, j) * X(i, :);
        end
        mu(j,:) = mu(j, :)/Nk(j);
        p(j) = Nk(j)/N;
    end
    
    for j = 1 : K
        for i = 1 : N
            for d = 1 : D
                sigma(d,d,j)  = sigma(d,d,j) + h(i, j) * (X(i, d) - mu(j, d))^2; 
            end
        end
        sigma(:,:,j) = sigma(:,:,j)/Nk(j);
        %sigma(:,:,k) = fresh(sigma(:,:,k));
    end
    
    
    
    % Evaluate the log-likelihood and check for convergence of either
    % the parameters or the log-likelihood. If not converged, go to E-step.
    loglikelihood = 0;
    for i = 1:N
        loglikelihood = loglikelihood + log(sum(hd(i,:)));
    end


    % Check for convergence of parameterse
    tol = 10e-3;    
    errorLoglikelihood = abs(loglikelihood-prevLoglikelihood);
    if (errorLoglikelihood <= tol)
        converged = 1; 
    end

    errorMu = abs(mu(:)-prevMu(:));
    errorSigma = abs(sigma(:)-prevSigma(:));
    errorPi = abs(p(:)-prevPi(:));

    if (all(errorMu <= tol) && all(errorSigma <= tol) && all(errorPi <= tol))
        converged = 1;
    end
    
    if(round > 20)
        converged = 1;
    end

    prevLoglikelihood = loglikelihood;
    prevMu = mu;
    prevSigma = sigma;
    prevPi = p;
end % while 