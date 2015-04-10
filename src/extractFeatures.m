function [features, points] = extractFeatures(I, points)
% Extracts a set of features from an image at the given points
% I = the given image
% points = a binary array that signifies which points in I to extract
% features from

% [labelsX, labelsY] = ind2sub(size(learningSetPoints), find(learningSetPoints == 1));
% flatSize = [size(I,1)*size(I,2), 1];
if nargin == 1
    % If no points given, use results of our edge detection algorithm as points
    points = findEdges(I);
end
if size(I,3) == 3
   I = rgb2gray(I); 
end
[gX, gY] = imgradientxy(I);
gMag = imgradient(I);
gX = gX(points);
gY = gY(points);
gMag = gMag(points);
features = [gX, gY, gMag];
end