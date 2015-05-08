% extractMPb.m
% Extracts the local edge strength for SVM
% INPUT:
% I = the given RGB image
% points = a binary array that signifies which points in I to extract
% features from
% OUTPUT:
% features = feature vector
% points = point vector

function [features, points] = extractMPb(I, points)

if nargin == 1
    % If no points given, use results of our edge detection algorithm as points
    points = findEdges(I);
end
if size(I,3) == 3
   I = rgb2gray(I); 
end

multiPb = mPb(I, points);
%load('multiPb img20.mat');
%multiPb = multiPb3;
multiPb = multiPb(points);
features = multiPb;
end