%Pb
%if pixel coordinates are out of bounds, returns variance of 0
%center: [x y] coordinates of point to investigate
%theta: bifurcating angle in degrees
function [variance] = Pb(topMask, botMask, center, image)

%Variables
radius = 20;
binNumber = 25;
%

imageSize = size(image);
x = center(1);
y = center(2);
variance = 0;

%skips edge cases
if any([center<= radius, center >= (imageSize - radius)])
    return;
end

rad = floor(size(topMask,1)/2);
tValue = cropImg(image, x, y, rad, topMask);
bValue = cropImg(image, x, y, rad, botMask);

%compute gradient
tValue(tValue == 0) = NaN;
bValue(bValue == 0) = NaN;

xBins = 0:1/(binNumber-1):1;
[tCounts, ~] = hist(tValue, xBins);
tCounts = tCounts/sum(tCounts);
[bCounts, ~] = hist(bValue, xBins);
bCounts = bCounts/sum(bCounts);
for i = 1:binNumber
    %only evalutes nonzero denominators
    if tCounts(i) + bCounts(i) == 0
    else
        variance = variance + (((tCounts(i) - bCounts(i))^2) / (tCounts(i) + bCounts(i)))*.5;
    end
end


% display
% close all;
% bar([tCounts, bCounts]);
% figure;
% imshow(imfuse(cropTop, cropBot));
end