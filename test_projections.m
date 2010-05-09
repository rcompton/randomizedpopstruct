
%
%Test all the above stuff
%

m = 300;
n = 2500;
sigma = .5;
sparsity = 0.03*n;

M = make_fake_data(m,n,sigma,sparsity);

make_projections(M)

get_test_stastic(M)