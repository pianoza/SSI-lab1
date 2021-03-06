%% Initialization
%im = double(imread('p1_images/coins.png'));
im = double(imread('p1_images/color.tif'));
%im = double(rgb2gray(imread('p1_images/color.tif')));
%im = double(imread('p1_images/woman.tif'));
%im = double(imread('p1_images/gantrycrane.png'));

% Get the image dimensions
[height, width, dim] = size(im);
% Declare mean variable as an array with length dim:
% if image is colored: dim == 3; else dim = 1;
mean = zeros(1, dim);
% Declaring the queue for BFS algorithm. check with static and dynamic
% allocation
queue = []; %zeros(height*width, 2);
% Array for segmentation result
seg = zeros(height, width);
% Const array for neighbourhood operations
dx = [0, 1, 0, -1, 1, -1, 1, -1];
dy = [-1, 0, 1, 0, 1, 1, -1, -1];
% 4 or 8 connectivity
nN = 4; %size(dx, 2);
% Define the threshold
T = 70.0;
% Initial number of regions
nR = 0;

% Region growing algorithm
for i = 1 : height
    for j = 1 : width
        % if the pixel at (i, j) doesn't belong to any region
        if seg(i, j) == 0
           l = 1;                % pointer to the top of the queue
           r = 1;                % pointer to the end of the queue
           mean(:) = im(i, j,:); % initialize mean (for all channels) with the seed point value
           queue(l, 1) = i;      % initialize the queue 
           queue(l, 2) = j;      % with the seed point spatial coordinates
           n = 1;                % number of pixels in the current region
           nR = nR + 1;          % increase the number of regions
           seg(i, j) = nR;       % assign the label to the seed point
           while l <= r          % repeat until the queue has elements
               xc = queue(l, 1); % get the top element from the queue
               yc = queue(l, 2); % get the top element from the queue
               for k = 1 : nN    % for the adjacent pixels check
                   % if they don't get out of the boundary and they don't
                   % belong to any region yet
                   if xc+dx(k) > 0 && xc+dx(k) <= height && yc+dy(k) > 0 && yc+dy(k) <= width && seg(xc+dx(k), yc+dy(k)) == 0
                       % calculate the euclidean distance from the adjacent
                       % pixel and the mean. the first two lines are just
                       % helper variables to obtain the intensity values
                       % from the all channels
                       tmp = zeros(1, dim);
                       tmp(:) = im(xc+dx(k), yc+dy(k), :);
                       euclidean = norm(tmp(:) - (mean(:)/n), 2);
                       % if euclidean distance is below the threshold
                       if euclidean <= T
                           % add that pixel to the queue
                           r = r + 1;
                           queue(r, 1) = xc + dx(k);
                           queue(r, 2) = yc + dy(k);
                           % assign the label
                           seg(xc+dx(k), yc+dy(k)) = nR;
                           % increase the number of pixels in the region
                           n = n + 1;
                           % update mean
                           tmp = zeros(1, dim);
                           tmp(:) = im(xc+dx(k), yc+dy(k), :);
                           mean(:) = mean(:) + tmp(:);
                       end;
                   end;
               end;
               % pop the first element from the queue and set the pointer
               % to the next element
               l = l + 1;
           end;
        end;
    end;
end;
%figure, imagesc(seg), axis equal;