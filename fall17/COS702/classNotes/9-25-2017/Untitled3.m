rbf = @(theta, c) c;
%reshape(r,[80, 1]);
ep = 70;
N =80;
neval = 100;
theta = 2*pi*(1:N)'/N;
r = exp(sin(theta)).*(sin(2*theta)).^2+exp(cos(theta)).*(cos(2*theta)).^2;
%x = exp(sin(theta)).*(sin(2*theta)).^2;; y = exp(cos(theta)).*(cos(2*theta)).^2;
x = r.*cos(theta); y = r.*sin(theta);
%nx = exp(sin(theta)).*(sin(2*theta)).^2 + 2*cos(theta).*cos(2*theta).*sin(2*theta);
dr= cos(theta).*exp(sin(theta)).*sin(2*theta).^2+4*exp(sin(theta)).*sin(2*theta).*cos(2*theta)-sin(theta).*exp(cos(theta)).*cos(2*theta).^2-4*exp(cos(theta)).*cos(2*theta).*sin(2*theta);
nx = dr.*sin(theta) + r.*cos(theta);
%ny = 2*exp(cos(theta)).*(cos(2*theta)).^2 - 2*sin(theta).*cos(2*theta).*sin(2*theta);
ny = -dr.*cos(theta) + r.*sin(theta);
dsites =[x y]; normals = [nx ny];
bmin = min(dsites, [], 1); bmax = max(dsites, [], 1);
delta = 0.005;
dsites(N+1:2*N, :)= dsites(1:N, :) +delta*normals;
dsites(2*N+1:3*N, :) = dsites(1:N, :)-delta*normals;
rhs = [zeros(N,1); ones(N,1); -ones(N,1)];
ctrs= dsites;
DM_data = DistanceMatrix(dsites, ctrs);
IM = sqrt((ep*DM_data).^2+1);
coe = IM\rhs;
bmin=min(dsites, [], 1); bmax = max(dsites, [], 1);
xgrid = linspace(bmin(1), bmax(1), neval);
ygrid = linspace(bmin(2), bmax(2), neval);
[xe, ye] = meshgrid(xgrid, ygrid);
epoints = [xe(:) ye(:)];
DM_eval = DistanceMatrix(epoints, ctrs);
EM = rbf(ep, DM_eval);
Pf = EM*coe;
figure; hold on; view([-30,30])
plot3(dsites(:,1), dsites(:, 2), rhs, 'r.', 'markersize', 20);
mesh(xe, ye, reshape(Pf, neval, neval));
axis tight; hold off
figure; hold on
plot(dsites(1:N, 1), dsites(1:N, 2), 'bo');
contour(xe,ye,reshape(Pf,neval,neval),[0 0],'r'); axis square;
hold off