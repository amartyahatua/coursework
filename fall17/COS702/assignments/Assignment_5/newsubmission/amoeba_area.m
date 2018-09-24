% PointCloud2D
% MQ RBF

%%Exact area of Amoeba%%
  rmax = @(t) exp(sin(t)).*(sin(2*t)).^2+exp(cos(t)).*(cos(2*t)).^2;
  fun = @(t,r) r;
  exactArea = integral2(fun,0,2*pi,0,rmax);
  minep = 60;
  maxep = 100;

  rbf = @(e,r) sqrt((e*r).^2+1); 
  ep = 70;
  %N = 80;   % number of data points
  areaAmoeba = zeros(4,20);
  minError = 100;
  errorSet = zeros(4,20);
  index = 0;
  for N = 50:40:200
      index = index + 1;
  neval = 100; % to create neval-by-neval evaluation grid
  t = 2*pi*(1:N)'/N;
  r = exp(sin(t)).*(sin(2*t)).^2+exp(cos(t)).*(cos(2*t)).^2;
  dr = cos(t).*exp(sin(t)).*sin(2*t).^2+4*exp(sin(t)).*sin(2*t).*cos(2*t)-sin(t).*exp(cos(t)).*cos(2*t).^2-4*exp(cos(t)).*cos(2*t).*sin(2*t);
  
  x = r.*cos(t);
  y = r.*sin(t);
    
  nx = dr.*sin(t) + r.*cos(t);
  ny = -dr.*cos(t) + r.*sin(t);


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
  %Shape parameter%
  [ep,fval] = fminbnd(@(ep) CostEps(ep,rbf,DM_data,rhs),minep,maxep);
  
  IM=sqrt((ep*DM_data).^2+1); %IM = rbf(ep,DM_data);
  coe=IM\rhs; %RBF coefficient
  % Compute new bounding box
  bmin = min(dsites,[],1);  bmax = max(dsites,[],1);
  % Create neval-by-neval equally spaced evaluation locations
  % in bounding box
  xgrid = linspace(bmin(1),bmax(1),neval);
  ygrid = linspace(bmin(2),bmax(2),neval);
  [xe,ye] = meshgrid(xgrid,ygrid);
  Error = zeros(500,1);
  areaError = 100;
%   totalPoints = 1900;
  count = 0;
  for totalPoints = 100:100:20000
      count = count + 1;
      p=haltonset(2);
      pts=net(p,totalPoints); %Generate 1000 2D Halton points
      epoints_hlt = [pts(:,1).*(bmax(1)-bmin(1))+bmin(1)  pts(:,2).*(bmax(2)-bmin(2))+bmin(2)];
      DM_eval_hlt = DistanceMatrix(epoints_hlt,ctrs);
      EM_hlt = rbf(ep,DM_eval_hlt);
      Pf_hlt = EM_hlt * coe;
      areaOfRectangle = (bmax(1)-bmin(1)).*(bmax(2)-bmin(2));
      pointsInSide = sum(sum(Pf_hlt<=0));
      
      areaAmoeba(index,totalPoints/100) = areaOfRectangle*(pointsInSide/totalPoints);
      errorSet(index,totalPoints/100) = abs(exactArea-(areaOfRectangle*(pointsInSide/totalPoints)));
     
      if (areaError > abs(exactArea-(areaOfRectangle*(pointsInSide/totalPoints))))
          areaError = abs(exactArea-(areaOfRectangle*(pointsInSide/totalPoints)));
          leastAreaError = abs(exactArea-(areaOfRectangle*(pointsInSide/totalPoints)));
          approxArea = areaOfRectangle*(pointsInSide/totalPoints);
          haltonPoints = totalPoints;
          boundaryPoint = N;
      end
  end
  end
  
  epoints = [xe(:) ye(:)];
  DM_eval = DistanceMatrix(epoints,ctrs);
  EM = rbf(ep,DM_eval);
  Pf = EM * coe;
  %Plot extended data with 2D-fit Pf
  errorSetTrans = errorSet';
  
  figure; hold on; view([-30,30])
  plot3(dsites(:,1),dsites(:,2),rhs,'r.','markersize',20);
  mesh(xe,ye,reshape(Pf,neval,neval));
  %mesh(pts(:,1), pts(:,2),reshape(Pf,neval,neval));
  axis tight; hold off
  % Plot data sites with interpolant (zero contour of 2D-fit Pf)
  figure; hold on
  plot(dsites(1:N,1),dsites(1:N,2),'bo');
  contour(xe,ye,reshape(Pf,neval,neval),[0 0],'r'); axis square;
  hold off
  
  figure;
  hold on;
  plot(errorSetTrans);
  

  fprintf('Exact area of amoeba %f.\n',exactArea);
  fprintf('Approximate area of amoeba %f using %d Halton points and %d Boundary points.\n',approxArea,haltonPoints,boundaryPoint);
  fprintf('Value of shape parameter calculated by LOOCV is %f',ep);
  fprintf('\nMinimum error %f.\n',leastAreaError);
