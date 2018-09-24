clear all;
load -ascii intpts.txt; % input scattered data (x,y,z)
k=300; n=7;
X=intpts(1:k,1); Y=intpts(1:k,2); Z=intpts(1:k,3);
DM=DistanceMatrix(intpts(1:k,1:2),intpts(1:k,1:2)); % Create the distance matrix
%x2=X*ones(1,k)-ones(k,1)*X';  y2=Y*ones(1,k)-ones(k,1)*Y';
% x2=repmat(X,1,k)-repmat(X',k,1);
% y2=repmat(Y,1,k)-repmat(Y',k,1);
% DM=sqrt(x2.^2+y2.^2);  %Distance Matrix
A=DM.^n; % Interpolation matrix
c=A\Z;   % Solve A*c=Z
%Reconstruction of the surface.
[M N]=meshgrid(-3:0.15:3);
x1=M(:);  y1 =N(:);  %test gridded points
testpt=[x1 y1];  m=length(x1); [n1,n2]=size(M);
xt=repmat(x1,1,k)-repmat(X',m,1);
yt=repmat(y1,1,k)-repmat(Y',m,1);
DM1=sqrt(xt.^2+yt.^2);  %Distance Matrix
% DM1=DistanceMatrix(testpt,intpts(1:k,1:2));
B=DM1.^n*c; %approximate values on mesh gridded points
E=reshape(B,n1,n1);
figure(1) %plot the input data
scatter3(X,Y,Z,'filled'); view(65,20);
figure(2) %plot the reconstructed surface
surf(M,N,E,'FaceColor','green','EdgeColor','none')
view(65,20); 
camlight left; 
lighting gouraud %phong  
