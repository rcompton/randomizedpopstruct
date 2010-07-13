function D = reduce_coverage(M, p)
%
% undersample a matrix and put it into sparse format
% M is the full data
% p is the probability that an entry is drawn from M
% eg// reduce_coverage(M,.1) draws 10% from M
%
[m n] = size(M);
num_nonzeros = m*n*p;

locs = randsample(1:m*n, num_nonzeros);
%column major, wtf matlab?
[I J] = ind2sub(size(M), locs);
assert(all(size(I) == size(J)));

D = zeros(num_nonzeros,1);
for k=1:num_nonzeros
    D(k) = M(I(k),J(k));
end

D = spconvert([I',J',D; m,n,0]);