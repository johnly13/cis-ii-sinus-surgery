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

scaledGradient = extractFeaturesScaledGrad(grayIm, points);
hist = extractFeaturesHist(grayIm, points);
mPb = extractMPb(grayIm, points);
features = [scaledGradient; hist; mPb];
end