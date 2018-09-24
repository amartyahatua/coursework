 A = double(imread('lena.jpg'));
 [s v d] = svd(A);
 n = 10;
% 
 re = s(:,1:n)*v(1:n,1:n)*d(:,1:n)';
 figure;
 imshow(mat2gray(re));
% 
 n = 40;
% 
 re = s(:,1:n)*v(1:n,1:n)*d(:,1:n)';
 figure;
 imshow(mat2gray(re));
% 
% 
 n = 80;
% 
 re = s(:,1:n)*v(1:n,1:n)*d(:,1:n)';
 figure;
 imshow(mat2gray(re));
% 
% 
% T = diag(v);
% t1 = cumsum(T)/ sum(T);
% plot(1:256,t1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tiger = rgb2gray(imread('tiger.jpg'));
%tiger1 = im2double(imresize(tiger,0.5));
%imshow(tiger1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tiger = imread('tiger.jpg');


%if determinatnt = 0 then nontrivial solution is there
% other wise trivial solution is there 















