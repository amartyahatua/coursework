image = double(imread('tiger.jpg'));
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
 
ranks = [10,50,100,200];
len = size(ranks)
 for i = 1:len(2)
     disp(ranks(i))
     n = ranks(i);
     [s v d] = svd(R);
     re_r = s(:,1:n)*v(1:n,1:n)*d(:,1:n)';
     [s v d] = svd(G);
     re_g = s(:,1:n)*v(1:n,1:n)*d(:,1:n)';
     [s v d] = svd(B);

     re_b = s(:,1:n)*v(1:n,1:n)*d(:,1:n)';
     re = zeros(size(image));
     re(:,:,1) = re_r;
     re(:,:,2) = re_g;
     re(:,:,3) = re_b;

     subplot(2,2,i);
     imshow(mat2gray(re));
     ttitleStr = strcat('Image with Rank=',int2str(n));
     mt(i) = title(ttitleStr);
 end
