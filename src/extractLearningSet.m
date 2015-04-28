function points = extractLearningSet(labeledImage, color)
if nargin == 1
    color = [0, 245, 245];
end
I = labeledImage;
points = I(1:end,1:end,1) == color(1) & ...
    I(1:end,1:end,2) >= color(2) & ...
    I(1:end,1:end,3) >= color(3);
end

