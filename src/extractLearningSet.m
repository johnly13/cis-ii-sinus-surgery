% extractLearningSet.m
% Extracts non zero points from labeled image
% INPUT:
% labeledImage = mono-color image
% OUTPUT:
% poitns = extracted nonzero points

function points = extractLearningSet(labeledImage)
I = labeledImage;
points = I > 0;
end

