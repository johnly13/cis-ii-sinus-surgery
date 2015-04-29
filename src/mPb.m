function [out] = mPb(images, points)


%Images: images to be processed. 3rd index corresponds to channels
%points: binary array
imageSize = size(images(:,:,1));
[centerIndex(:,2), centerIndex(:,1)] = find(points);

%narrow sampled points
numToSkip = 2;
numOfAngles = 8;
%

centerIndex = centerIndex(1:numToSkip+1:size(centerIndex,1), :);
index = sub2ind(imageSize, centerIndex(:,2), centerIndex(:,1));


%iterate through each theta and each channel and find greatest chi square
%distance
channels = size(images,3);
theta = 0:(180/numOfAngles):180;
out = zeros(imageSize);
for k = 1:size(centerIndex,1);
    center = centerIndex(k,:);
    currIndex = index(k);
    PbArray = zeros(1,numOfAngles);
    for j = 1:numOfAngles
        currTheta = theta(j);
        for i = 1:channels
            image = images(:,:,i);
            PbArray(j) = PbArray(j) + Pb(currTheta,center,image);     
        end
    end
    out(currIndex) = max(PbArray);
end
end
