% bifurcateCircle.m
% Creates 2 semicircle masks
% INPUT:
% theta = angle in degrees of bifurcation
% rad = radius in pixels of disk
% OUTPUT:
% topMask = binary mask of the top half of the disk
% bottomMask = binary mask of the bottom half of the disk

function [topMask, bottomMask] = bifurcateCircle(theta, rad)

    theta = deg2rad(theta);
    mask = fspecial('disk',rad)~=0;
    pixelIndex = find(mask);
    [I, J] = ind2sub(size(mask),pixelIndex);
    
    %determine above and below points
    B = round([rad + 100*cos(theta), rad + 100*sin(theta)]);
    position = sign((B(2)-rad)*(I-rad) - (B(1)-rad)*(J-rad));
    
    topMask = NaN(size(mask));
    bottomMask = NaN(size(mask));
    topMask(pixelIndex(position == 1)) = 1;
    bottomMask(pixelIndex(position <= 0)) = 1;
    topMask = topMask;
    bottomMask = bottomMask;
end