%im = double(imread('p1_images/coins.png'));
%im = double(imread('p1_images/color.tif'));
im = double(rgb2gray(imread('p1_images/color.tif')));
%im = double(imread('p1_images/woman.tif'));
%im = double(imread('p1_images/gantrycrane.png'));
tic
queue = [];%zeros(10000, 2);
seg = zeros(size(im, 1), size(im, 2));
dx = [0, 1, 0, -1, 1, -1, 1, -1];
dy = [-1, 0, 1, 0, 1, 1, -1, -1];
T = 20.0; %threshold
nR = 0; %number of regions
for i = 1 : size(im, 1)
    for j = 1 : size(im, 2)
        if seg(i, j) == 0
           l = 1;
           r = 1;
           mean = im(i, j);
           queue(l, 1) = i;
           queue(l, 2) = j;
           n = 1;
           nR = nR + 1;
           seg(i, j) = nR;
           while l <= r
               xc = queue(l, 1);
               yc = queue(l, 2);
               for k = 1 : size(dx, 2)
                   if xc+dx(k) > 0 && xc+dx(k) <= size(im, 1) && yc+dy(k) > 0 && yc+dy(k) <= size(im, 2)
                       if seg(xc+dx(k), yc+dy(k)) == 0 && abs(im(xc+dx(k), yc+dy(k)) - (mean/n)) <= T
                           r = r + 1;
                           queue(r, 1) = xc + dx(k);
                           queue(r, 2) = yc + dy(k);
                           seg(xc+dx(k), yc+dy(k)) = nR;
                           n = n + 1;
                           mean = mean + im(xc+dx(k), yc+dy(k));
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