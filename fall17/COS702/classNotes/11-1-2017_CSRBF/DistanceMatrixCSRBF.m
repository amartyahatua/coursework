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
%--------------------------------------------------------------
% This is a NEW version of DistanceMatrixCSRBF.m, now also called
% DistanceMatrixCSRBF.m, adapted according to code written 
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
  function DM = DistanceMatrixCSRBF(dsites,ctrs,ep)
  N = size(dsites,1);  M = size(ctrs,1);
  % Build k-D tree for data sites
  % For each center (basis function), find the data sites
  % in its support along with u-distance
  support = 1/ep; nzmax = 25*N; DM = spalloc(N,M,nzmax);
  % old code used 2-norm distance, this one uses max-norm
  % The following code might be useful for anisotropic kernels
  % suppbox = [-support*ones(1,s); support*ones(1,s)]; 
  if M > N  % faster if more centers than data sites
     tTree = kd_buildtree(ctrs,0);
     for i = 1:N
%        [idx,dist,pts] = kd_rangequery2(tTree,dsites(i,:),suppbox);
        [idx,dist,pts] = kd_rangequery_ball(tTree,dsites(i,:),support);
%        [idx,dist,pts] = kd_rangequery_pnorm(tTree,dsites(i,:),support,2);
        DM(i,idx) = 1-ep*dist;
     end
  else
     tTree = kd_buildtree(dsites,0);
     for j = 1:M
%        [idx,dist,pts] = kd_rangequery2(tTree,ctrs(j,:),suppbox);
        [idx,dist,pts] = kd_rangequery_ball(tTree,ctrs(j,:),support);
%        [idx,dist,pts] = kd_rangequery4(tTree,ctrs(j,:),support,2);
        DM(idx,j) = 1-ep*dist;
     end
  end
  % Free the k-D Tree from memory.
  clear tTree   