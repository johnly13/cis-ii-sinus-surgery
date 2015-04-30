function [features, points] = extractFeaturesScaledGrad(I, points, scales)

if nargin == 2
   scales = 0:0.25:1; 
end
gradient = imgradient(I);
for scale = scales
    if scale ~= 1
        scaledGradient = imgradient(imresize(I, scale));
        gradient = gradient + scaledGradient/scale;
    end
end 
features = gradient(points);
end