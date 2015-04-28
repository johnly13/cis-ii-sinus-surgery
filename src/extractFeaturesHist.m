function [features, points] = extractFeaturesHist(I, points)
% Extracts a set of features from an image at the given points
% I = the given RGB image
% points = a binary array that signifies which points in I to extract
% features from

if nargin == 1
    % If no points given, use results of our edge detection algorithm as points
    points = findEdges(I);
end
r = 16;
bnum = ;

% Current features: hue, saturation, value (intensity)
Ib = rgb2gray(I);
sz = size(Ib);
[xg, yg] = meshgrid(1:sz(2), 1:sz(1));
edgepts = find(points > 0);
hists = zeros(floor(length(edgepts)), bnum);
count = 1;
for i = 1:length(edgepts)
    [x0,y0] = ind2sub(size(Ib),edgepts(i));
    x = xg - x0;
    y = yg - y0;
    cmask = x.^2 + y.^2 <= r.^2;
    cimg = double(Ib) .* cmask;
    cpix = cimg > 0;
    intensities = cimg(cpix);
    h = hist(intensities, bnum);
    hists(count,:) = h;
    count = count + 1;
    disp(i);
end
features = hists;
end