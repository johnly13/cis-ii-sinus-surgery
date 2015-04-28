% filter smoothness image, run after calcSmoothness.m

function fs = filterSmoothness(s, thresh)
    fs = s;
    for i = 1:size(fs,1)
        for j = 1:size(fs,2)
            if fs(i,j) < thresh
                fs(i,j) = 0;
            end
        end
    end
end