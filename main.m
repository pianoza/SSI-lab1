%im = double(imread('p1_images/coins.png'));
%im = double(imread('p1_images/color.tif'));
%im = double(rgb2gray(imread('p1_images/color.tif')));
im = double(imread('p1_images/woman.tif'));
%im = double(imread('p1_images/gantrycrane.png'));

[seg, n] = regionGrowing(im, 80, 8);
imagesc(seg), axis equal;
fprintf('Number of regions: %d\n', n)