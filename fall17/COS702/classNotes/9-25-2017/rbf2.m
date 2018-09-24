clear all;
f1 = @(x,y) .75*exp(-((9*x-2).^2+(9*y-2).^2)/4);
f2 = @(x,y) .75*exp(-((9*x+1).^2/49+(9*y+1).^2/10));
f3 = @(x,y) .5*exp(-((9*x-7).^2+(9*y-3).^2)/4);
f4 = @(x,y) .2*exp(-((9*x-4).^2+(9*y-7).^2));
testfunction = @(x,y) f1(x,y)+f2(x,y)+f3(x,y)-f4(x,y);
k=256; %total number of interpolation points
ctrs=haltonseq(k,2); % generate 256 random interpolation points (x,y)
x=ctrs(:,1); y=ctrs(:,2);
c1=.2;
% load intpts.txt
% ctrs=intpts;
% x=intpts(:,1); y=intpts(:,2); Z=intpts(:,3);  k=length(x);
% ctrs=haltonpts;
Z=testfunction(ctrs(:,1),ctrs(:,2)); % produce f(x,y)
% Create the interpolation matrix
DM=sqrt((x*ones(1,k)-ones(k,1)*x').^2+(y*ones(1,k)-ones(k,1)*y').^2);
% DM=DistanceMatrix(ctrs,ctrs);
A=sqrt(DM.^2+c1); %DM.^7;
% for i=1:k
%     for j=1:k
%         r=sqrt((ctrs(i,1)-ctrs(j,1))^2+(ctrs(i,2)-ctrs(j,2))^2);
%          A(i,j)= r^7;
%     end
% end
% find the coeficients c
c=A\Z;
%plot the orignial scatter data
figure(1)
scatter3(ctrs(:,1),ctrs(:,2),Z(:,1),'filled');
view(130,10);
title('Given Scatter Data');
%reconstruction of the surface
[M, N]=meshgrid(0:1/40:1);
x1=M(:); y1=N(:); k1=length(x1);
% DM1 = DistanceMatrix([x1 y1],ctrs);
xt1=repmat(x1,1,k); xt2=repmat(x',k1,1);
yt1=repmat(y1,1,k); yt2=repmat(y',k1,1);
DM1=(xt1-xt2).^2+(yt1-yt2).^2;  DM1=sqrt(DM1);
E=sqrt(DM1.^2+c1)*c;
exact=testfunction(x1,y1);
maxerr=norm(E-exact,inf);
% E=zeros(41);
% for i=1:41
%     for j=1:41
%           for k1=1:k
%             r=sqrt((M(i,j)-ctrs(k1,1))^2+(N(i,j)-ctrs(k1,2))^2);  
%             E(i,j)=E(i,j)+c(k1)*r^7; 
%           end
%     end    
% end
figure(2)
surf(M,N,reshape(E,41,41),'FaceColor','red','EdgeColor','none')
view(130,10);
camlight left; lighting phong
title('Reconstructed Surface')
fview=[160,20];
PlotError2D(M,N,E,exact,maxerr,41,fview);
PlotSurf(M,N,E,41,exact,maxerr,fview)
        