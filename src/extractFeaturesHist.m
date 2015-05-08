% extractFeaturesHist.m
% Extracts histogram feature from pixel using a circular mask
% INPUT:
% I = the given RGB image
% points = a binary array that signifies which points in I to extract
% features from
% OUTPUT:
% features = matrix of histogram values
% points = edge points that were calculated

function [features, points] = extractFeaturesHist(I, points)

if nargin == 1
    % If no points given, use results of our edge detection algorithm as points
    points = findEdges(I);
end
r = 16;
bnum = 16;
% Current features: hue, saturation, value (intensity)
Ib = rgb2gray(I);
edgepts = find(points > 0);
hists = zeros(floor(length(edgepts)), bnum);
count = 1;
mask = uint8(fspecial('disk',r)~=0);
for i = 1:length(edgepts)
    [y,x] = ind2sub(size(Ib),edgepts(i));
    window = cropImg(Ib,x,y,r,mask);
    w = double(window(:));
    h = hist(w,bnum);
    h = h/max(h);
    hists(count,:) = h;
    count = count + 1;
end
features = hists;
end