function x = get_a_classical_tw_stat(m,n)

M = randn(m,n).*1.0/sqrt(n);

sings = svd(M);

lmbda1 = sings(1)^2;

mu = ((sqrt(n - 1) + sqrt(m))^2)/n;
sig = ((sqrt(n - 1) + sqrt(m))/n)*(1.0/sqrt(n - 1) + 1.0/sqrt(m))^(1.0/3.0);

x = (lmbda1 - mu)/sig;
