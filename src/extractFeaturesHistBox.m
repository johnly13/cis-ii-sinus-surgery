% extractFeaturesHistBox.m
% Extracts a set of features from an image at the given points. Looks at
% entire image
% INPUT:
% I = the given RGB image
% points = a binary array that signifies which points in I to extract
% features from
% OUTPUT:
% features = matrix of histogram values
% points = edge points that were calculated

function [features, points] = extractFeaturesHistBox(I, points)


if nargin == 1
    % If no points given, use results of our edge detection algorithm as points
    points = findEdges(I);
end
r = 16;
bnum = 16;
% Current features: hue, saturation, value (intensity)
Ib = rgb2gray(I);
sz = size(Ib);
edgepts = find(points > 0);
hists = zeros(floor(length(edgepts)), bnum);
count = 1;
for i = 1:length(edgepts)
    [row,col] = ind2sub(size(Ib),edgepts(i));
    x0 = max(1,col - r);
    y0 = max(1,row - r);
    x1 = min(col + r, sz(2));
    y1 = min(row + r, sz(1));
    window = Ib(y0:y1,x0:x1);
    w = double(window(:));
    h = hist(w,bnum);
    h = h/sum(h);
    hists(count,:) = h;
    count = count + 1;
    disp(i);
end
gMag = imgradient(Ib);
gMag = gMag(points);
gMag = gMag./max(max(gMag));
features = [hists]; %gMag];
end