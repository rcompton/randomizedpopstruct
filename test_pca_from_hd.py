
from numpy import *

import pca_from_hd

#make a rank k A
m,k,n = 1124, 27, 352 
A = dot(random.standard_normal((m,k)), random.standard_normal((k,n)))
A *= 1.0/linalg.norm(A)

#do a python svd, V is output as Vh in pthon
u,s,v = linalg.svd(A, full_matrices=False)
print linalg.norm( A - dot(u, dot(diag(s), v)) ), "usual SVD error"

#do a Tygert svd
U,S,V = pca_from_hd.pca(A, 27, 2)
print linalg.norm( A - dot(U, dot(diag(S), V)) ), "Tygert SVD error"
