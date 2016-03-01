im = double(imread('p1_images/coins.png'));
[center,U,obj_fcn] = fcm(im, 4);
im1 = zeros(size(im,1), size(im,2));
k = 1;
for i = 1:size(im, 1)
    im1(i,:) = center(k, :);
end;
for i = 1:size(im,2)
    im1(:,i) = U(k,:);
end;
imshow(im1,[]);