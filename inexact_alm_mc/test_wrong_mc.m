clear all;

m = 500;
n = 1500;
r = 10;

p = m*n*1;

Axact = randn(m,r)*randn(r,n);
Sxact = (randn(m,n)>2).*randn(m,n)*200;

Omegah = randsample(1:m*n, p);

B = zeros(m,n);
B(Omegah) = Axact(Omegah)+Sxact(Omegah);

tic
[Aaprox,iter,svp,SS] = wrong_alm_mc(B, 1e-4);
toc
%Aaprox = Aaprox.U*Aaprox.V';

fprintf('err in low rank:%f \n',norm(Aaprox-Axact)/norm(Axact));
fprintf('err in sparse:%f \n',norm(SS-Sxact)/norm(Sxact));
