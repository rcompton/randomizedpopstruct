function [I J col omega] = my_randsample(m, n, k)

%omega = ceil(rand(k, 1) * m * n);
%omega = unique(omega);
%while length(omega) < k    
%    omega = [omega; ceil(rand(k-length(omega), 1)*m*n);];
%    omega = unique(omega);
%end

omega = randsample(1:m*n,k)';

[I,J] = ind2sub([m,n], omega);
col = [0; find(diff(J)); k]; 




