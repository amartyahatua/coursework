% PointCloud2D
% MQ RBF
clear
load('bunny449.mat');
  [rows,cols] = size(dsites);
  rbf = @(e,r) sqrt((e*r).^2+1); 
  ep = 70;
  N = rows;   % number of data points
  neval = 20; % to create neval-by-neval evaluation grid
  x = dsites(:,1);
  y = dsites(:,2);
  z = dsites(:,3);
  
  nx = normals(:,1);
  ny = normals(:,2);
  nz = normals(:,3);
  
   dsites = [x y z]; normals = [nx ny nz];
  % Produce auxiliary points along normals "inside" and "outside"
  bmin = min(dsites,[],1);  bmax = max(dsites,[],1);
  bdim = max(bmax-bmin);
  % Distance along normal at which to place new points
  delta = .005; %bdim/300;
  % Create new points
  dsites(N+1:2*N,:) = dsites(1:N,:) + delta*normals(1:N,:);
  dsites(2*N+1:3*N,:) = dsites(1:N,:) - delta*normals(1:N,:);
  % "original" points have rhs=0,
  % "inside" points have rhs=-1, "outside" points have rhs=1
  rhs = [zeros(N,1); ones(N,1); -ones(N,1)];
  % Let centers coincide with data sites
  ctrs = dsites;
  DM_data = DistanceMatrix(dsites,ctrs);
  IM=sqrt((ep*DM_data).^2+1); %IM = rbf(ep,DM_data);
  coe=IM\rhs; %RBF coefficient
  % Compute new bounding box
  bmin = min(dsites,[],1);  bmax = max(dsites,[],1);
  % Create neval-by-neval equally spaced evaluation locations
  % in bounding box
  xgrid = linspace(bmin(1),bmax(1),neval);
  ygrid = linspace(bmin(2),bmax(2),neval);
  zgrid = linspace(bmin(3),bmax(3),neval);
  [xe,ye,ze] = meshgrid(xgrid,ygrid,zgrid);
  epoints = [xe(:) ye(:) ze(:)];
  
  
  numberOfDivision = 10;
  [nrow,ncol] = size(epoints);
  for i=1:numberOfDivision
        starts = (nrow/numberOfDivision)*(i-1)+1;
        ends = (nrow/numberOfDivision)*i;
        DM_eval = DistanceMatrix(epoints(starts:ends,:),ctrs);
        EM = rbf(ep,DM_eval);
        Pf(starts:ends,:) = EM * coe;
  end
  if(neval>ends)
      DM_eval = DistanceMatrix(epoints(ends+1:neval,:),ctrs);
      EM = rbf(ep,DM_eval);
      Pf(ends+1:neval,:) = EM * coe;
  end
  
  % Plot extended data with 2D-fit Pf
  figure; hold on; view([-30,30])
  isosurface(xe,ye,ze,reshape(Pf,neval,neval,neval),0);
%   mesh(xe,ye,reshape(Pf,neval,neval));
%   axis tight; hold off
%   % Plot data sites with interpolant (zero contour of 2D-fit Pf)
%   figure; hold on
%   plot(dsites(1:N,1),dsites(1:N,2),'bo');
%   contour(xe,ye,reshape(Pf,neval,neval),[0 0],'r'); axis square;
%   hold off