% filterSmoothness.m
% Filter input to eliminate values below the threshold
% INPUT:
% s = smoothness map
% thresh = threshold
% OUTPUT:
% fs = filtered smoothness map

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