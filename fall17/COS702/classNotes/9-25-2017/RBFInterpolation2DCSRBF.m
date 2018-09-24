% RBFInterpolation2DCSRBF
% Script that performs 2D RBF interpolation with CSRBFs
% Calls on: DistanceMatrixCSRBF
  % Define a Wendland CSRBF and shape parameter in shifted form for use
  % with DistanceMatrixCSRBF
  rbf = @(e,r) r.^4.*(5*spones(r)-4*r); ep=10;
  % Define Franke's function as testfunction
  f1 = @(x,y) 0.75*exp(-((9*x-2).^2+(9*y-2).^2)/4);
  f2 = @(x,y) 0.75*exp(-((9*x+1).^2/49+(9*y+1).^2/10));
  f3 = @(x,y) 0.5*exp(-((9*x-7).^2+(9*y-3).^2)/4);
  f4 = @(x,y) 0.2*exp(-((9*x-4).^2+(9*y-7).^2));
  testfunction = @(x,y) f1(x,y)+f2(x,y)+f3(x,y)-f4(x,y);
  N = 1089; gridtype = 'u'; nt=1550;
  % Load data points
  tic
  name = sprintf('Data2D_%d%s',N,gridtype); load(name)
  ctrs = dsites;
  %neval = 40; grid = linspace(0,1,neval);
  %[xe,ye] = meshgrid(grid); epoints = [xe(:) ye(:)];
  epoints=haltonseq(nt,2);
  % Evaluate the test function at the data points
  rhs = testfunction(dsites(:,1),dsites(:,2))
  % Compute distance matrix between the data sites and centers
  DM_data = DistanceMatrixCSRBF_cschen(dsites,ctrs,ep);
  % Compute interpolation matrix
  IM = rbf(ep,DM_data);
  % Compute distance matrix between evaluation points and centers
  DM_eval = DistanceMatrixCSRBF_cschen(epoints,ctrs,ep);
  % Compute evaluation matrix
  EM = rbf(ep,DM_eval);
  % Compute RBF interpolant
  % (evaluation matrix * solution of interpolation system)
  Pf = EM * (IM\rhs);
  % Compute exact solution, i.e.,
  % evaluate test function on evaluation points
  exact = testfunction(epoints(:,1),epoints(:,2));
  % Compute errors on evaluation grid
  maxerr = norm(Pf-exact,inf);
  %rms_err = norm(Pf-exact)/neval;
  toc
  %fprintf('RMS error:     %e\n', rms_err)
  fprintf('Maximum error: %e\n', maxerr)
  
