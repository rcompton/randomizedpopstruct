
%
%Test all the above stuff
%

m = 200;
n = 5550;
sigma = .5;
sparsity = 0.03*n;

M = make_fake_data(m,n,sigma,sparsity);

make_projections(M)

get_test_stastic(M)

%
%Get the TW table
%Per-Olaf Persson made this
%yeah, wtf, there's only 3 or 4 mathematicians in the world
%
x = dlmread('twtable', '\s');

tw_density = x(:,3);
tw_distribution = x(:,2);
x = x(:,1);

plot(x, tw_density);
plot(x, tw_distribution);


N= length(x);
h = (6.0+6.0)/N;

for i=1:N
    classical_data(i) = get_a_classical_tw_stat(m,n);
end

for i=1:N
    xi = -6+i*h;
    tw_emp_dist(i) = norm( double(classical_data(:) > xi(:)),1);
end

tw_emp_dist = tw_emp_dist ./ max(tw_emp_dist);

figure()
title('emperical dist')
plot(x, tw_emp_dist)

figure()
title('emperical dist vs real dist')
plot(tw_emp_dist, tw_distribution, 'rx')
hold on
plot([0:1.0/N:1], [0:1.0/N:1])



