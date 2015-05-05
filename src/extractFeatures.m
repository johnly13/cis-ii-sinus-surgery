function [features, points] = extractFeatures(I, points)
% Extracts a set of features from an image at the given points
% I = the given image
% points = a binary array that signifies which points in I to extract
% features from

if nargin == 1
    % If no points given, use results of our edge detection algorithm as points
    filter = fspecial('gaussian', 20, 4);
    thresh = 0;
    red = I(:,:,1);
    red_highC = imadjust(red,[0 0.7],[0 1]);
    points = findEdges(red_highC, 0, 0, 0, filter, ...
    thresh, 0, 'Canny');
end
if size(I,3) == 3
   grayIm = im2double(rgb2gray(I)); 
end

scaledGradient = extractScaledGrad(grayIm, points);
hist = extractFeaturesHist(I, points);
mPb = extractMPb(grayIm, points);
features = [scaledGradient hist mPb];
end