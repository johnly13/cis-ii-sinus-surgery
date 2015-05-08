%DNI

function [svm, trainingFeatures, trainingLabels] = trainSVM2(I, true_set, false_set)

trainingFeatures = extractFeatures2(I, true_set);
trainingLabels = ones(size(trainingFeatures, 1), 1);

nonFeatures = extractMPb(I, false_set);
trainingFeatures = [trainingFeatures ; nonFeatures];

trainingLabels = [trainingLabels ; zeros(size(nonFeatures,1), 1)];

svm = fitcsvm(trainingFeatures(1:2:end,:), trainingLabels(1:2:end), ...
    'KernelFunction', 'rbf');
end