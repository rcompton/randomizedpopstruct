function [coordsx coordsy X] = make_projections(M)

[m n] = size(M);

%the slow way to get e-vals and e-vecs
X = M*M';
[vecs vals] = eig(X);

%otherwise I get confused
vals = diag(vals)

[max_eval max_idx] = max(vals);

max_vec = vecs(:, max_idx);

%they're all >0 since X' = X
vals(max_idx) = 0.0;

%get 2nd e-vec
[sec_eval max_idx] = max(vals);
sec_vec = vecs(:, max_idx);

% figure()
% title('first PC')
% plot(max_vec)
% 
% figure()
% title('second PC')
% plot(sec_vec)

coordsx = zeros(1,m);
coordsy = zeros(1,m);

for i=1:m
    indvi = X(i,:)/norm(X(i,:));
    
    coordsx(i) = indvi*max_vec;
    coordsy(i) = indvi*sec_vec;
end

figure()
title('strcuture')
plot(coordsx, coordsy, 'rx')


