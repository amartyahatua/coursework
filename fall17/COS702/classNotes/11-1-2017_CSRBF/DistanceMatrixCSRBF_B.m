% DM = DistanceMatrixCSRBF(dsites,ctrs,ep)
% Forms the distance matrix of two sets of points in R^s
% for compactly supported radial basis functions, i.e.,
%      DM(i,j) = || datasite_i - center_j ||_2.
% The CSRBF used with this code must be given in shifted form
% rbf2(u) = rbf(r), u=1-e*r.
% For example, the Wendland C2
% rbf = @(e,r) max(1-e*r,0).^4.*(4*e*r+1);
% becomes
% rbf2 = @(u) u.^4.*(4*u+5);
% Input
%   dsites: Nxs matrix representing a set of N data sites
%              in R^s (i.e., each row contains one
%              s-dimensional point)
%   ctrs:   Mxs matrix representing a set of M centers for
%              RBFs in R^s (also one center per row)
%   ep:        determines size of support of basis function.
%              Small ep yields wide function,
%              i.e., supportsize = 1/ep
% Output
%   DM:     NxM SPARSE matrix that contains the Euclidean
%              u-distance (u=1-e*r) between the i-th data
%              site and the j-th center in the i,j position
% Uses:     k-D tree package by Guy Shechter from
%              MATLAB Central File Exchange
  function DM = DistanceMatrixCSRBF_B(dsites,ctrs,ep)
  N = size(dsites,1);  M = size(ctrs,1);
  % Build k-D tree for data sites
  % For each center (basis function), find the data sites
  % in its support along with u-distance
  support = 1/ep;
  T1(N).id=[]; T2(N).id=[];  i1=0;
  iend = 0;
     tree=kdtree_build(ctrs);
for i = 1:N
    [idx,dist] = kdtree_ball_query(tree,dsites(i,:),support);
    newentries = length(idx);
    iend = iend + newentries;
    T1(i).id=idx';
    T2(i).id=1-ep*dist';
end
     rowidx=zeros(1,iend);colidx=rowidx;validx=rowidx;
for i=1:N
    ns=length(T1(i).id);
    rowidx(i1+1:i1+ns)=i;
    colidx(i1+1:i1+ns)=T1(i).id;
    validx(i1+1:i1+ns)=T2(i).id;
    i1=i1+ns;
end
  N=max(N);M=max(M);
  DM = sparse(rowidx,colidx,validx,N,M);
