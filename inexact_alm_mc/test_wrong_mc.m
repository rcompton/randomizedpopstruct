clear all;

m = 400;
n = 1300;
r = 10;

p = m*n*.1;

Axact = randn(m,r)*randn(r,n);
Omegah = randsample(1:m*n, p);

B = zeros(m,n);
B(Omegah) = Axact(Omegah);

tic
Aaprox = wrong_alm_mc(B, 1e-4);
toc
%Aaprox = Aaprox.U*Aaprox.V';

fprintf('err:%f \n',norm(Aaprox-Axact)/norm(Axact));