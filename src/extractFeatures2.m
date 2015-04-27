function [features, points] = extractFeatures2(I, points)
% Extracts a set of features from an image at the given points
% I = the given image
% points = a binary array that signifies which points in I to extract
% features from

if nargin == 1
    % If no points given, use results of our edge detection algorithm as points
    points = findEdges(I);
end
if size(I,3) == 3
   I = rgb2gray(I); 
end

% Current features: x gradient, y gradient, gradient magnitude
% [gX, gY] = imgradientxy(I);
% gMag = imgradient(I);
% gX = gX(points);
% gY = gY(points);
% gMag = gMag(points);

%multiPb = mPb(I, points);
load('multiPb img20.mat');
multiPb = multiPb2;
multiPb = multiPb(points);
features = multiPb;
end