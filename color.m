im = double(imread('p1_images/coins.png'));
%im = double(imread('p1_images/color.tif'));
%im = double(rgb2gray(imread('p1_images/color.tif')));
%im = double(imread('p1_images/woman.tif'));
%im = double(imread('p1_images/gantrycrane.png'));
[height, width, dim] = size(im);
tic
mean = zeros(1, dim);
queue = [];%zeros(10000, 2);
seg = zeros(height, width);
dx = [0, 1, 0, -1, 1, -1, 1, -1];
dy = [-1, 0, 1, 0, 1, 1, -1, -1];
nN = size(dx, 2);
T = 70.0; %threshold
nR = 0; %number of regions
for i = 1 : height
    for j = 1 : width
        if seg(i, j) == 0
           l = 1;
           r = 1;
           mean(:) = im(i, j,:);
           queue(l, 1) = i;
           queue(l, 2) = j;
           n = 1;
           nR = nR + 1;
           seg(i, j) = nR;
           while l <= r
               xc = queue(l, 1);
               yc = queue(l, 2);
               for k = 1 : nN
                   if xc+dx(k) > 0 && xc+dx(k) <= height && yc+dy(k) > 0 && yc+dy(k) <= width && seg(xc+dx(k), yc+dy(k)) == 0
                       tmp = zeros(1, dim);
                       tmp(:) = im(xc+dx(k), yc+dy(k), :);
                       euclidean = norm(tmp(:) - (mean(:)/n), 2);
                       if euclidean <= T
                           r = r + 1;
                           queue(r, 1) = xc + dx(k);
                           queue(r, 2) = yc + dy(k);
                           seg(xc+dx(k), yc+dy(k)) = nR;
                           n = n + 1;
                           tmp = zeros(1, dim);
                           tmp(:) = im(xc+dx(k), yc+dy(k), :);
                           mean(:) = mean(:) + tmp(:);
                       end;
                   end;
               end;
               l = l + 1;
           end;
        end;
    end;
end;
toc
figure, imagesc(seg), axis equal;