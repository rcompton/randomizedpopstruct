clear all;

m = 1000;
n = 1210;
r = 13;

p = m*n*.1;

Axact = randn(m,r)*randn(r,n);
Omegah = randsample(1:m*n, p);

B = zeros(m,n);
B(Omegah) = Axact(Omegah);

Aaprox = wrong_alm_mc(B, 1e-5);
Aaprox = Aaprox.U*Aaprox.V';

fprintf('err:%f \n',norm(Aaprox-Axact)/norm(Axact));