
from numpy import *

#
#Same as Tygert's matlab code.
#
def pca(A, k = 16, its = 2, p = 12, pseudo = True):
    l = k + p
    m,n = shape(A)

    #
    # SVD A directly if (its+1)*l >= m/1.25 or (its+1)*l >= n/1.25.
    # this should not happen...
    #
    if ((its+1)*l >= m/1.25) or ((its+1)*l >= n/1.25) :
        print "just use a usual SVD..."
        return

    #
    # Algorithm 4.3 in Halko
    #

    #when n > m it's more efficient to work
    #with the transpose
    if m >= n:

        # Draw l random samples from the range of A
        if pseudo:
            random.seed(0)
        omega = 2*random.standard_normal((n, l)) - ones((n,l))

        # At this point Tygert uses variance 2, 1 centered 
        # I don't know why he does that 
        Y = dot(A, omega)
    
        # The block sample matrix
        W = zeros((m, (its+1)*l))
        W[0:m, 0:l] = Y

        #The power iterations
        for it in range(1, its+1):
            Y = dot(transpose(A), Y)
            Y = dot(A, Y)
            W[0:m, (it*l):(it+1)*l ] = Y
        #del(Y)

        #First l steps of a rank-revelaing QR
        #are more efficient than usual QR
        #the Q I get here is different but still a basis
        Q,R = linalg.qr(Y)
        del(R, W, Y)

        # Another pass and form B in the paper
        # then take SVD of B
        U2, S, V = linalg.svd( dot(transpose(Q), A), full_matrices=False )
        U = dot(Q, U2)
        print linalg.norm( dot(Q, dot(U2, dot(diag(S), V)) ) - dot(Q, dot(transpose(Q),A)) ), "suck!"
  
        print linalg.norm( A - dot(Q, dot(transpose(Q),A)) ), "A-QQtA" 
       
        [ud, sd, vd] = linalg.svd( A - dot(Q, dot(transpose(Q),A)) )
        print sd[:10], "spectral norm of A-QQtA"

        del(Q, U2)

        # Note: Python's svd returns V' not V
        U = U[:, 0:k]
        V = V[0:k, :]
        S = S[0:k]
        return (U, S, V)
   
    else:
        print "lazy"
        return

