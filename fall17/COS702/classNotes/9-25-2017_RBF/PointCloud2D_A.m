% PointCloud2D
% MQ RBF
  rbf = @(e,r) sqrt((e*r).^2+1); 
  ep = 70;
  N = 80;   % number of data points
  neval = 100; % to create neval-by-neval evaluation grid
  t = 2*pi*(1:N)'/N;
  x=(1+cos(4*t).^2).*cos(t); y=(1+cos(4*t).^2).*sin(t);
  nx=cos(t)+cos(t).*cos(4*t).^2-8*sin(t).*cos(4*t).*sin(4*t);
  ny=sin(t)+sin(t).*cos(4*t).^2.+8*cos(t).*cos(4*t).*sin(4*t);
 %cc=.92;
 % x=(1+cc*sin(t)).*cos(t); y=(1+cc*sin(t)).*sin(t);
 % nx=cos(t)+2*cc*sin(t).*cos(t); ny=sin(t)-cc*cos(2*t);
  dsites = [x y]; normals = [nx ny];
  % Produce auxiliary points along normals "inside" and "outside"
  bmin = min(dsites,[],1);  bmax = max(dsites,[],1);
  bdim = max(bmax-bmin);
  % Distance along normal at which to place new points
  delta = .005; %bdim/300;
  % Create new points
  dsites(N+1:2*N,:) = dsites(1:N,:) + delta*normals;
  dsites(2*N+1:3*N,:) = dsites(1:N,:) - delta*normals;
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
  [xe,ye] = meshgrid(xgrid,ygrid);
  epoints = [xe(:) ye(:)];
  DM_eval = DistanceMatrix(epoints,ctrs);
  EM = rbf(ep,DM_eval);
  Pf = EM * coe;
  % Plot extended data with 2D-fit Pf
  figure; hold on; view([-30,30])
  plot3(dsites(:,1),dsites(:,2),rhs,'r.','markersize',20);
  mesh(xe,ye,reshape(Pf,neval,neval));
  axis tight; hold off
  % Plot data sites with interpolant (zero contour of 2D-fit Pf)
  figure; hold on
  plot(dsites(1:N,1),dsites(1:N,2),'bo');
  contour(xe,ye,reshape(Pf,neval,neval),[0 0],'r'); axis square;
  hold off
