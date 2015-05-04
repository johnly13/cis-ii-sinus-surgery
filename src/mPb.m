function [PbArray] = mPb(image, points)
tic;

%Images: images to be processed
%points: binary array
image = im2double(image);
imageSize = size(image);
[centerIndex(:,2), centerIndex(:,1)] = find(points);

%narrow sampled points
numToSkip = 0;
numOfAngles = 8;
rad = 20;
%

centerIndex = centerIndex(1:numToSkip+1:size(centerIndex,1), :);
index = sub2ind(imageSize, centerIndex(:,2), centerIndex(:,1));


%iterate through each theta and find greatest chi square
%distance
theta = 0:(180/numOfAngles):180;
PbArray = zeros(size(image));
for k = 1:numOfAngles
    currTheta = theta(k);
    [topMask, botMask] = bifurcateCircle(currTheta,rad);
    for j = 1:size(centerIndex,1);
        currCenter = centerIndex(j,:);
        currIndex = index(j);
        var = Pb(topMask, botMask ,currCenter,image);
        if var > PbArray(currIndex)
            PbArray(currIndex) = var;
        end
    end
end
toc;
end
