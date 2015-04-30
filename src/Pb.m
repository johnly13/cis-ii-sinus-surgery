%Pb
%if pixel coordinates are out of bounds, returns variance of 0
%center: [x y] coordinates of point to investigate
%theta: bifurcating angle in degrees
function [variance] = Pb(theta, center, image)

%Variables
radius = 20;
binNumber = 25;
%

imageSize = size(image);
theta = deg2rad(theta);
center = [center(2) center(1)];
variance = 0;

%skips edge cases
if any([center<= radius, center >= (imageSize - radius)])
    return;
end

%construct circle
[rowsInImage, columnsInImage] = meshgrid(1:imageSize(2), 1:imageSize(1));
circlePixels = (rowsInImage - center(2)).^2 ...
    + (columnsInImage - center(1)).^2 <= radius.^2;
[pixelIndex(:,1), pixelIndex(:,2)] = find(circlePixels);

%determine end of bifucatinon vector
B = round([center(1) + 100*cos(theta), center(2) + 100*sin(theta)]);

%determine points above and below bifurcation line
position = sign( (B(2)-center(2))*(pixelIndex(:,1)-center(1)) - ...
    (B(1)-center(1))*(pixelIndex(:,2)-center(2)) );
top = pixelIndex(position == 1, :);
bottom = pixelIndex(position <= 0, :);

topPixels = zeros(imageSize);
bottomPixels = zeros(imageSize);

topPixels(sub2ind(size(topPixels), top(:,1), top(:,2))) = 1;
bottomPixels(sub2ind(size(bottomPixels), bottom(:,1), bottom(:,2))) = 1;

%compute gradient
tIndex = find(topPixels);
bIndex = find(bottomPixels);
tValue = im2double(image(tIndex));
bValue = im2double(image(bIndex));
xBins = 0:1/(binNumber-1):1;
[tCounts, tCenters] = hist(tValue, xBins);
tCounts = tCounts/sum(tCounts);
[bCounts, bCenters] = hist(bValue, xBins);
bCounts = bCounts/sum(bCounts);
for i = 1:binNumber
    %only evalutes nonzero denominators
    if tCounts(i) + bCounts(i) == 0
    else
        variance = variance + (((tCounts(i) - bCounts(i))^2) / (tCounts(i) + bCounts(i)))*.5;
    end
end


%% display
% close all;
% paddedA = NaN(max(length(tValue), length(bValue)), 1);
% paddedB = NaN(max(length(tValue), length(bValue)), 1);
% paddedA(1:length(tValue)) = tValue;
% paddedB(1:length(bValue)) = bValue;
% 
% hist([paddedA paddedB],xBins);
% 
% 
% figure;
% E = image;
% color = cat(3, zeros(size(E)), ones(size(E)), ones(size(E)));
% imshow(image, 'initialMag', 100);
% hold on;
% h = imshow(color); 
% set(h, 'AlphaData', topPixels);
% hold off;
% 
% hold on;
% color = cat(3, ones(size(E)), zeros(size(E)), ones(size(E)));
% h1 = imshow(color); 
% set(h1, 'AlphaData', bottomPixels);
end