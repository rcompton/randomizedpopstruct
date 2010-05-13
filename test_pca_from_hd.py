
from numpy import *

import pca_from_hd


m,n = 1000, 250

A = random.standard_normal((m,n))

Q,R = linalg.qr(A)

print linalg.norm(A - dot(Q, dot(transpose(Q), A) ) ), "normal QR"


u,s,v = linalg.svd(A, full_matrices=False)

U,S,V = pca_from_hd.pca(A)
#U,S,V = pca_from_hd.pca(A, 100, 3, 12)

print shape(u)
print shape(s)
print shape(v)

print linalg.norm( dot( (dot(u, diag(s) )), v) - A )

print shape(U), "U"
print shape(diag(S)), "S"
print shape(V), "V"

print shape( dot( (dot(U, diag(S) )), V ) ), "USV shape"
print linalg.norm( dot( (dot(U, diag(S) )), V ) - A)

print S
print s[:10]

