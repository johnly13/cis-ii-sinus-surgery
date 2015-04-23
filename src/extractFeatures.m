function [features, points] = extractFeatures(I, points)
% Extracts a set of features from an image at the given points
% I = the given image
% points = a binary array that signifies which points in I to extract
% features from

if nargin == 1
    % If no points given, use results of our edge detection algorithm as points
    points = findEdges(I);
end
if size(I,3) == 3
   grayIm = im2double(rgb2gray(I)); 
end

% Current features: x gradient, y gradient, gradient magnitude
[gX, gY] = imgradientxy(grayIm);
gMag = imgradient(grayIm);
imshow([gX, gY]);

gX = gX(points);
gY = gY(points);
gMag = gMag(points);
features = [gX, gY, gMag];
end