function [features, points] = extractFeaturesScaledGrad(I, points, scale)

if nargin == 2
   scale = 0.2; 
end
gradient = imgradient(imresize(I, scale));
gradient = imresize(gradient, 1/scale, 'lanczos3');
features = gradient(points);
end