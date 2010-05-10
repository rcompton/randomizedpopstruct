function tw = get_test_stastic(C)
%
%Exactly same method as in the old paper
%
[m n] = size(C);

%
%form M via the Johnstone normalization
%
%normalize the column means to 0
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


%
%Product
%
X = M*M';

%
%Full SVD
%
[vecs vals] = eig(X);

vals = diag(vals);

traceX = sum(vals);
traceXX = sum(vals.^2);

%
%Estimate the number of independent dimensions
%
nprime = (m+1)*traceX^2/( (m-1)*traceXX - traceX^2 );
mprime = m-1;

%
%Normalize leading eval
%
max_eval = max(vals);
l = mprime*max_eval/traceX;

%
%classical TW
%
mu = ((sqrt(nprime - 1) + sqrt(m))^2)/nprime;
sig = ((sqrt(nprime - 1) + sqrt(m))/nprime)*(1.0/sqrt(nprime - 1) + 1.0/sqrt(m))^(1.0/3.0);


tw = (l-mu)/sig
