function [svm, trainingFeatures, trainingLabels] = trainSVM(I, trainingPoints)
% Trains an SVM based on an edges in an image and a training set of points 
% I = the original image
% trainingPoints = a binary array of ground truth points

trainingFeatures = extractFeatures(I, trainingPoints);
trainingLabels = ones(size(trainingFeatures, 1), 1);
nonFeatureEdges = findEdges(imfilter(I, fspecial('gaussian', 25, 15))) & ~trainingPoints;
nonFeatures = extractFeatures(I, nonFeatureEdges);
trainingFeatures = [trainingFeatures ; nonFeatures];
trainingLabels = [trainingLabels ; zeros(size(nonFeatures,1), 1)];

svm = fitcsvm(trainingFeatures(1:2:end,:), trainingLabels(1:2:end), ...
    'KernelFunction', 'rbf');
end