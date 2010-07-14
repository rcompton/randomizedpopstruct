clear all;

m = 400;
n = 510;
r = 10;

p = m*n*.1;

Axact = randn(m,r)*randn(r,n);
Omegah = randsample(1:m*n, p);

B = zeros(m,n);
B(Omegah) = Axact(Omegah);

Aaprox = wrong_alm_mc(B, 1e-5);
Aaprox = Aaprox.U*Aaprox.V';

fprintf('err:%f \n',norm(Aaprox-Axact)/norm(Axact));