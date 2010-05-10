function C = make_fake_data(m, n, sigma, sparsity)

C = zeros(m,n);

sparsity = int8(sparsity);

interesting_slots1 = randsample( 1:n , sparsity);
interesting_slots2 = randsample( 1:n , sparsity);

%
% If you add this in then you will DEFINTELY get structure
% so your TW will be huge.
%

% for i=1:(m/2)-1
%     C(2*i, interesting_slots1) = C(2*i, interesting_slots1) + 2.0;
%     C(2*i+1, interesting_slots1) = C(2*i+1, interesting_slots1) + 1.0;
%     C(i + m/2, interesting_slots2) = C(i + m/2, interesting_slots2) + 2.0;
% end

%this is weird and clumsy
if sigma ~= 0.0
    noise_bounder = 1.0/sigma;
    noise = (randn(m,n) > noise_bounder) + 2*(randn(m,n) > noise_bounder);
    C = C + noise;
end


    

