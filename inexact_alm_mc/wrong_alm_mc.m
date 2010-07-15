function [A iter svp] = wrong_alm_mc(D, tol, maxIter)

%clear global;
%global A Sparse_Z;

%addpath PROPACK;

if nargin < 2
    tol = 1e-4;
elseif tol == -1
    tol = 1e-4;
end

if nargin < 3
    maxIter = 1000;
elseif maxIter == -1
    maxIter = 1000;
end

% read sparse matrix D
[m n] = size(D);
%[I J V] = find(D);

omegah = find(D);
omegahbar = find(D==0);

%p = length(I);
%col = [0; find(diff(J)); p];
%Sparse_Z = D;
%clear D;

% initialize
%Y = zeros(p, 1);
Y = zeros(m,n);
%Z = zeros(p, 1);
%Z = zeros(m,n);
%A.U = zeros(m, 5);
%A.V = zeros(n, 5);
A = zeros(m,n);
E = zeros(m,n);
SS = zeros(m,n);
d_norm = norm(D, 'fro');
%mu = 0.3/(lansvd('Axz','Atxz',m,n,1,'L'));
mu = 0.3/norm(D);
rho_s = length(omegah) / (m * n);
rho = 1.1 + 2.5 * rho_s;

tau = 1/sqrt(max(m,n));

sv = 5;
svp = sv;

shrink = inline('max(abs(A)-mu, 0).*((A>0)-.5)*2','A','mu');

% Iteration
iter = 0;
converged = false;
stopCriterion = 1;
while ~converged
    %% alternative projection    
    iter = iter + 1;
    %if iter == 1
    %    Z = D;
    %else
    %    Z = Z + 1/mu * Y;
        %Sparse_Z = spconvert([I,J,Z; m,n,0]);
    %end
    if stopCriterion > 10 * tol
        options.tol = 10*tol;
    else
        options.tol = min(0.1*tol, 0.01/mu);
    end
    %% update E
    E = zeros(m,n);
    %E(omegah) = A(omegah);
    %E = E - A;
    E(omegahbar) = D(omegahbar) - A(omegahbar) - SS(omegahbar) + (1/mu)*Y(omegahbar);
    
    %% update SS
    %SS = shrink(D-A-E+(1/mu)*Y,tau/mu);
    
    %% predict the rank of A.     
    %[A.U,S,A.V] = lansvd('Axz','Atxz',m,n,sv,'L',options);
    %[U,S,V] = lansvd(A+Z,m,n,sv,'L',options);
    %[U,S,V] = pca(A+Z,sv);   
    [U,S,V] = pca(D-E-SS+(1/mu)*Y, sv);

    diagS = diag(S);
    diagS = diagS(1:sv);
    svn = length(find(diagS > 1/mu));
    svp = svn;
    
    ratio = diagS(1:end-1)./diagS(2:end);
    [max_ratio, max_idx] = max(ratio);
    if max_ratio > 2
        svp = min(svn, max_idx);
    end
    if svp < sv %|| iter < 10
        sv = min(svp + 1, n);
    else
        sv = min(svp + 10, n);
    end
    %% update A  
    U = U(:,1:svp);
    S = S(1:svp, 1:svp);
    V = V(:,1:svp);
    A = U*shrink(S,1/mu)*V';

    
    %% update Y
    %Z = zeros(m,n);
    %Z(omegah) = A(omegah) + SS(omegah);
    %Z = D - Z;    
    Y = Y - mu*(A+E+SS-D);
    
    %% stop Criterion
    stopCriterion = norm(A+E+SS-D, 'fro') / d_norm;
    if stopCriterion < tol
        converged = true;
    end
    
    %% display
    if mod( iter, 10) == 0
        disp(['#svd ' num2str(iter) ' r(A) ' num2str(svp)...
            ' svn ' num2str(svn) ' max_idx ' num2str(max_idx) ' sv ' num2str(sv) ...
            ' stopCriterion ' num2str(stopCriterion) ' mu ' num2str(mu)]);
    end
    
    %% Maximum iterations reached
    if ~converged && iter >= maxIter
        disp('Maximum iterations reached') ;
        converged = 1 ;
    end
    
    %% update mu
    mu = mu*rho;
    
end

