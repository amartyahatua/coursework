%input:
%X:Ten classes of input data  
%K: the number of eigenvectors and eigenvalues
%Te: Test data set
%Lte: index of the class of data set
%Output:
%Js:the index of the selected class
%er: error of the test
function [Js,er]=PCA_handwriting(X,Y,K,Te,Lte)
U=zeros(784,240); Xb=zeros(784,10);
% Training procedure using PCA
for i=1:10
    X1=X(logical(Y(:,i)),:);
    [u,~]=princomp(double(X1));
    xbi=mean(X1);
    U(:,(i-1)*K+1:(i*K))=u(:,1:K);
    Xb(:,i)=xbi;
end
%Testing procedure to find the fit
Lte=Lte(:);
M=length(Lte);
Js=zeros(M,1);
for m=1:M
    xw=double(Te(:,m));
    e=zeros(1,10);
    for j=1:10
        Uj=U(:,((j-1)*K+1):(j*K));
        xbj=double(Xb(:,j));
        zj=Uj'*(xw-xbj);
        xjh=Uj*zj+xbj;
        e(j)=norm(xw-xjh); %distance between the test data and each class of trained data
    end
    [~,ind]=min(e);%Find the minimum distance
     Js(m)=ind;
end
E=(Lte~=Js); %check how many data matched
er=sum(E)/M ;  % the error of test
fprintf('Error: %6.4f\n',er)
end