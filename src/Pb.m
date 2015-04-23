%Pb
%if pixel coordinates are out of bounds, returns variance of 0
%center: [x y] coordinates of point to investigate
function [variance] = Pb(theta, center, image)

%Variables
radius = 5;
binNumber = 25;
%

imageSize = size(image);
theta = deg2rad(theta);
center = [center(2) center(1)];
variance = 0;
if any([center<= radius, center >= (imageSize - radius)])
    return;
end

[rowsInImage, columnsInImage] = meshgrid(1:imageSize(2), 1:imageSize(1));
circlePixels = (rowsInImage - center(2)).^2 ...
    + (columnsInImage - center(1)).^2 <= radius.^2;
[pixelIndex(:,1), pixelIndex(:,2)] = find(circlePixels);

B = round([center(2) + 100*cos(theta), center(1) + 100*sin(theta)]);

%determine points above and below bifurcation line
position = sign( (B(2)-center(2))*(pixelIndex(:,1)-center(1)) - ...
    (B(1)-center(1))*(pixelIndex(:,2)-center(2)) );
top = pixelIndex(position == 1, :);
bottom = pixelIndex(position <= 0, :);

topPixels = zeros(imageSize);
bottomPixels = zeros(imageSize);

% can be made more efficient if linear indexing is used
for i = 1:size(top,1)
    topPixels(top(i,1), top(i,2)) = 1;
end
for i = 1:size(bottom,1)
    bottomPixels(bottom(i,1),bottom(i,2)) = 1;
end

%compute gradient
tIndex = find(topPixels);
bIndex = find(bottomPixels);
tValue = im2double(image(tIndex));
bValue = im2double(image(bIndex));

[tCounts, tCenters] = hist(tValue, binNumber);
tCounts = tCounts/sum(tCounts);
[bCounts, bCenters] = hist(bValue, binNumber);
bCounts = bCounts/sum(bCounts);
for i = 1:binNumber
    variance = variance + (((tCounts(i) - bCounts(i))^2) / (tCounts(i) + bCounts(i)))*.5;
end


%% display
% histogram(tValue,binNumber);
% hold on;
% histogram(bValue,binNumber);
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