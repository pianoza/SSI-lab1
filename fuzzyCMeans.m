function seg = fuzzyCMeans(im, clusters)
    data = reshape(im, [], 1);
    intensities = linspace(0, 255, clusters);
    seg = zeros(size(im, 1), size(im, 2));
    [center, U] = fcm(data, clusters);
    for i = 1:size(im,1)
        for j = 1:size(im,2)
            t = 1;
            m = abs(im(i,j) - center(t));
            for k = 2:clusters
                if abs(im(i,j) - center(k)) < m
                    t = k;
                    m = abs(im(i,j) - center(k));
                end;
            end;
            seg(i, j) = intensities(t);
        end;
    end;
end