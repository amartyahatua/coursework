clear all;
load('mnist_all.mat')
imgs = [train0(1:10, :); 
        train1(1:10, :);
        train2(1:10, :);
        train3(1:10, :);
        train4(1:10, :)];
imgs = im2double(imgs);
%Show all 50 training characters
for i = 1:50
    subplot(5, 10, i);
    imshow(reshape(imgs(i, :), 28, 28));
end          %show the training data set
% PCA procedure
[coeff,score,latent] = princomp(double(imgs),'econ');
figure;   % show the Eigenface
for i=1:49
    subplot(7, 7, i);
    imshow(reshape(coeff(:, i), 28, 28));
end
figure; %To be clearer, show the complement of Eigenface
for i=1:49
    subplot(7, 7, i);
    imshow(1.0 - reshape(coeff(:, i), 28, 28));
end
base_img =  mean(imgs); %the average face of the image
figure; imshow(reshape(base_img, 28, 28)); 
%Reconstruct the first character using the first n Eigenfaces
img1 = base_img';
n=2;
for i = 1:n
    img1 = img1 + coeff(:, i).*score(11, i);
end
figure; imshow(reshape(img1, 28, 28)); %show the reconstructed character
%Reconstruct the first character using first 30 Eigenfaces 
img2 = base_img';
for i = 1:30
    img2 = img2 + coeff(:, i).*score(11, i);
end
figure; imshow(reshape(img2, 28, 28));