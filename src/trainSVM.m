function [svm, trainingFeatures, trainingLabels] = trainSVM(I1, I2, I3, trainingPoints1, trainingPoints2, trainingPoints3)
% Trains an SVM based on an edges in an image and a training set of points 
% I = the original image
% trainingPoints = a binary array of ground truth points

trainingFeatures1 = extractFeatures(I1, trainingPoints1);
trainingFeatures2 = extractFeatures(I2, trainingPoints2);
trainingFeatures3 = extractFeatures(I3, trainingPoints3);
trainingFeatures = [trainingFeatures1 ; trainingFeatures2; trainingFeatures3];
trainingLabels = ones(size(trainingFeatures, 1), 1);
nonFeatureEdges1 = findEdges(I1) & ~trainingPoints1;
nonFeatureEdges2 = findEdges(I2) & ~trainingPoints2;
nonFeatureEdges3 = findEdges(I3) & ~trainingPoints3;
nonFeatures1 = extractFeaturesHist(I1, nonFeatureEdges1);
nonFeatures2 = extractFeaturesHist(I2, nonFeatureEdges2);
nonFeatures3 = extractFeaturesHist(I3, nonFeatureEdges3);
nonFeatures = [nonFeatures1; nonFeatures2; nonFeatures3];
trainingFeatures = [trainingFeatures; nonFeatures];
trainingLabels = [trainingLabels ; zeros(size(nonFeatures,1), 1)];

svm = fitcsvm(trainingFeatures(1:2:end,:), trainingLabels(1:2:end), ...
    'KernelFunction', 'rbf');
end