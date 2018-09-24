function ceps = CostEps(ep,pde,rbf,DM1,DM2,rhs)
A1=pde(DM1, ep);
A2 = rbf(DM2,ep);
A=[A1;A2];
invA = inv(A);
errorvector = (invA*rhs)./diag(invA);
ceps = norm(errorvector);
end