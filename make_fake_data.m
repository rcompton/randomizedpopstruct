function M = make_fake_data(m, n, sigma, sparsity)

C = zeros(m,n);

sparsity = int8(sparsity);

interesting_slots1 = randsample( 1:n , sparsity);
interesting_slots2 = randsample( 1:n , sparsity);

for i=1:(m/2)-1
    C(2*i, interesting_slots1) = 2.0;
    C(2*i+1, interesting_slots1) = 1.0;
    C(i + m/2, interesting_slots2) = 2.0;
end

%this is weird and clumsy
if sigma ~= 0.0
    noise_bounder = 1.0/sigma;
    noise = (randn(m,n) > noise_bounder) + 2*(randn(m,n) > noise_bounder);
    C = C + noise;
end

%normalize the column means to be 0
mu = zeros(n);
for j=1:n
    mu(j) = (1.0/m)*sum(C(:,j));
end

p = mu/2.0;

%stupid and inefficient
M = zeros(m,n);

%this needs an epsilon with my weird noise adding
epsilon = 0.001;
for i=1:m
    for j=1:n
        M(i,j) = ( C(i,j) - mu(j) )/sqrt( abs(p(j)*(1-p(j))) + epsilon);
    end
end


    

