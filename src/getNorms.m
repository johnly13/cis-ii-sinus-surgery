% getNorms.m
% Computes normal vectors for a given point on an edge
% INPUT:
% points = binary array of points
% OUTPUT:
% norms = normal vectors
% xpos = xposition of vector origin
% ypos = yposition of vector origin

function [norms, xpos, ypos] = getNorms(points)
points = uint8(points);
    r = 8;
    edgepts = find(points > 0);
    mask = uint8(fspecial('disk',r)~=0);
    norms = zeros(length(edgepts),1);
    xpos = zeros(length(edgepts),1);
    ypos = zeros(length(edgepts),1);
    for i = 1:length(edgepts)
        [y,x] = ind2sub(size(points),edgepts(i));
        window = cropImg(points,x,y,r,mask);
        w = double(window(:));
        ep = find(w > 0);
        [epy,epx] = ind2sub(size(mask),ep);
        p = polyfit(epx,epy,1);
        slope = p(1);
        norms(i) = -1/slope;
        xpos(i) = x;
        ypos(i) = y;
    end
end