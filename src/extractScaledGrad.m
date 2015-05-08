% extractScaledGrad.m
% Extracts SVM features for the scaled gradient 
% INPUT:
% I = the given RGB image
% points = a binary array that signifies which points in I to extract
% features from
% OUTPUT:
% features = feature vector
% points = point vector

function [features, points] = extractFeaturesScaledGrad(I, points, scale)
if nargin == 2
   scale = 0.2; 
end
gradient = imgradient(imresize(I, scale));
gradient = imresize(gradient, 1/scale, 'lanczos3');
features = gradient(points);
end