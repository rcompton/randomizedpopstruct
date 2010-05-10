
%
%Test all the above stuff
%

m = 50;
n = 1550;
sigma = .5;
sparsity = 0.03*n;

M = make_fake_data(m,n,sigma,sparsity);

make_projections(M)

get_test_stastic(M);

%
%Get the TW table
%Per-Olaf Persson made this
%yeah, wtf, there's only 3 or 4 mathematicians in the world
%
x = dlmread('twtable', '\s');
tw_density = x(:,3);
tw_distribution = x(:,2);
x = x(:,1);

%
%upsample the data
%
up_factor = 1;
x = interp(x, up_factor);
tw_density = interp(tw_density, up_factor);
tw_distribution = interp( tw_distribution, up_factor);

figure()
title('actual tw density')
plot(x, tw_density);

figure()
title('actual tw distribution')
plot(x, tw_distribution);

%
%upsample the data
%
N = length(x);
h = (6.0+6.0)/N;

disp Classic
classical_data = zeros(1,N);
tic()
for i=1:N
    classical_data(i) = get_a_classical_tw_stat(m,n);
end
toc()

tw_emp_dist = zeros(1,N);
for i=1:N
    xi = -6 + i*h;
    tw_emp_dist(i) = norm( double(classical_data(:) > xi(:)),1);
end

%normalize the dist
tw_emp_dist = tw_emp_dist ./ max(tw_emp_dist);

size(x)
size(tw_emp_dist)

figure()
title('emperical dist')
plot(x, tw_emp_dist)

figure()
title('emperical dist vs real dist')
plot(tw_emp_dist, tw_distribution, 'rx')
hold on
plot([0:1.0/N:1], [0:1.0/N:1])

%
%Begin Tygert's style PCA
%
disp Tygert
tic()
for i=1:N
    classical_data(i) = get_a_classical_tw_stat_via_tygert(m,n);
end
toc()

for i=1:N
    xi = -6 + i*h;
    tw_emp_dist(i) = norm( double(classical_data(:) > xi(:)),1);
end
%normalize the dist
tw_emp_dist = tw_emp_dist ./ max(tw_emp_dist);

figure()
title('emperical dist')
plot(x, tw_emp_dist)

figure()
title('emperical dist vs real dist')
plot(tw_emp_dist, tw_distribution, 'rx')
hold on
plot([0:1.0/N:1], [0:1.0/N:1])


% 
% disp('now get test stats from my silly data')
% 
% for i=1:N
%     M = make_fake_data(m,n,sigma,sparsity);  
%     simu_data(i) = get_test_stastic(M);
% end
% 
% for i=1:N
%     xi = -6+i*h;
%     tw_simu_dist(i) = norm( double(simu_data(:) > xi(:)),1);
% end
% 
% %normalize the dist
% tw_simu_dist = tw_simu_dist ./ max(tw_simu_dist);
% 
% figure()
% title('simu dist vs real dist')
% plot(tw_simu_dist, tw_distribution, 'rx')
% hold on
% plot([0:1.0/N:1], [0:1.0/N:1])


