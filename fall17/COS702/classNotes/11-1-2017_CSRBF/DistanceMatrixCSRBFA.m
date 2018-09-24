% DM = DistanceMatrixCSRBFA(dsites,ctrs,ep)
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
%--------------------------------------------------------------
% The NEW version of DistanceMatrixCSRBFA.m, now also called
% DistanceMatrixCSRBFA.m, has been written 
% by Stefano De Marchi, University of Padua, Italy,
% and slightly modified by Greg Fasshauer, IIT. 
% In particular, the code of kd_rangequery in the NEW Kdtree package was
% adapted to work with isotropic 2-norm range searches resulting in
% kd_rangequery_ball. 
%
% Important NOTICE
%        The OLD version, uses the k-D tree package by Guy Shechter 
%        The NEW version, uses the Kdtree package by Pramod Vermulapalli
%                         which is completely implemented in MATLAB
%        both dowloadable from MATLAB Central File Exchange
%--------------------------------------------------------------
  function DM = DistanceMatrixCSRBFA(dsites,ctrs,ep)
  N = size(dsites);  M = size(ctrs);
  % Build k-D tree for data sites
  % For each center (basis function), find the data sites
  % in its support along with u-distance
  support = 1/ep;
  nzmax = 25*N; rowidx = zeros(1,nzmax); colidx = zeros(1,nzmax);
  validx = zeros(1,nzmax); istart = 1; iend = 0;
  if M > N  % faster if more centers than data sites
     tTree = kd_buildtree(ctrs,0);
     for i = 1:N
        [idx,dist,pts] = kd_rangequery_ball(tTree,dsites(i,:),support);
        newentries = length(idx);
        iend = iend + newentries;
        rowidx(istart:iend) = repmat(i,1,newentries);
        colidx(istart:iend) = idx';
        validx(istart:iend) = 1-ep*dist';
        istart = istart + newentries;
     end
  else
     tTree = kd_buildtree(dsites,0);
     for j = 1:M
        [idx,dist,pts] = kd_rangequery_ball(tTree,ctrs(j,:),support);
        newentries = length(idx);
        iend = iend + newentries;
        rowidx(istart:iend) = idx';
        colidx (istart:iend)= repmat(j,1,newentries);
        validx(istart:iend) = 1-ep*dist';
        istart = istart + newentries;
     end
  end
  idx = find(rowidx);
  N=max(N);M=max(M);
  DM = sparse(rowidx(idx),colidx(idx),validx(idx),N,M);
  % Free the k-D Tree from memory.
  clear tTree   