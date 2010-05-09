function tw = get_test_stastic(M)
%
%Exactly same method as in the old paper
%

[m n] = size(M);

X = M*M';

[vecs vals] = eig(X);

vals = diag(vals);

traceX = sum(vals);
traceXX = sum(vals.^2);

nprime = (m+1)*traceX^2/( (m-1)*traceXX - traceX^2 );

nprime

mprime = m-1;

max_eval = max(vals);

l = mprime*max_eval/traceX;

mu = ((sqrt(nprime - 1) + sqrt(m))^2)/nprime;
sig = ((sqrt(nprime - 1) + sqrt(m))/n)*(1.0/sqrt(nprime - 1) + 1.0/sqrt(m))^(1.0/3.0);

tw = (l-mu)/sig;
