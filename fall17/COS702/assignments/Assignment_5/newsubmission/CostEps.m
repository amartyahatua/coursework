function ceps = CostEps(ep,rbf,DM,rhs)
A = rbf(ep,DM);
invA = pinv(A);
errorvector = (invA*rhs)./diag(invA);
ceps = norm(errorvector);