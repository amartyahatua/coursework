function bddpt=bumpy_sphere_nodes(nB)
% boundary points
rho1= @(theta,phi) 1+1/5*sin(6*theta).*sin(7*phi);
%%
%u=linspace(0,1,nB);
 %v=linspace(0,1,nB);
%  u=rand(nB,1);v=rand(nB,1);
%  [u,v]=meshgrid(u,v);
%  theta=2*pi*u;
%  phi=asin(2*v-1);
%  rho=rho1(theta,phi);
%  [x,y,z]=sph2cart(theta,phi, rho);
% bddpt=[x(:),y(:),z(:)];
%%
[bdpt,~]=generateB(nB,1,'sphere');bdpt=bdpt';
[theta,phi,~]=cart2sph(bdpt(:,1),bdpt(:,2),bdpt(:,3));
rho=rho1(theta,phi);
[xb,yb,zb]=sph2cart(theta,phi,rho);
bddpt=[xb,yb,zb];
%%
% theta=linspace(0,2*pi,nB);
% %phi=linspace(-pi/2,pi/2,nB);
% phi=linspace(0,pi,nB);
% [theta, phi]=meshgrid(theta,phi);
% rho=1+1/6*sin(6*theta).*sin(7*phi);
% u=cos(phi);
% x=rho.*sqrt(1-u.^2).*cos(theta);
% y=rho.*sqrt(1-u.^2).*sin(theta);
% z=rho.*u;
% bddpt=[x(:),y(:),z(:)];
%%
%%intnode
% x=linspace(-1.5,1.5,nI);
% y=linspace(-1.5,1.5,nI);
% z=linspace(-1.5,1.5,nI);
% [Lx,Ly,Lz]=meshgrid(x,y,z);
% % tri=delaunayn(bddpt);
% % tn=tsearchn(bddpt,tri,[Lx(:) Ly(:) Lz(:)]);
% % IsInside=~isnan(tn);
% % intnode=[Lx(IsInside) Ly(IsInside) Lz(IsInside)];
% 
% [theta,phi,rho]=cart2sph(Lx,Ly,Lz);
% d=0;
% for l=1:numel(rho)
%     if rho(l)<rho1(theta(l),phi(l));
%         d=d+1;
%         Ix(d)=Lx(l);
%         Iy(d)=Ly(l);
%         Iz(d)=Lz(l);
%     end
%    
% end
%  intnode=[Ix' Iy' Iz'];
 %plot3(xb,yb,zb,'ob');