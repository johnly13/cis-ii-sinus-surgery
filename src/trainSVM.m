function [svm, trainingFeatures, trainingLabels] = trainSVM(I, TSP)
% Trains an SVM based on an edges in an image and a training set of points 
% I = the original image
% trainingPoints = a binary array of ground truth points
trainingFeatures = [];
nonFeatures = [];
sz = size(I);
len = sz(4);
filter = fspecial('gaussian', 20, 4);
thresh = 0;
for i = 1:len
    TFstr = 'Extracting training feature ';
    TFstr = strcat(TFstr, num2str(i),'.');
    disp(TFstr);
    TF = extractFeatures(I(:,:,:,i), TSP(:,:,i));
    trainingFeatures = [trainingFeatures; TF];
end
trainingLabels = ones(size(trainingFeatures, 1), 1);
for i = 1:len
    TFstr = 'Extracting non-feature ';
    TFstr = strcat(TFstr, num2str(i),'.');
    disp(TFstr);
    red = I(:,:,1,i);
    red_highC = imadjust(red,[0 0.7],[0 1]);
    nFE = findEdges(red_highC, 0, 0, 0, filter, thresh, 0, 'Canny') & ~TSP(:,:,i);
    NF = extractFeatures(I(:,:,:,1), nFE);
    nonFeatures = [nonFeatures; NF];
end
trainingFeatures = [trainingFeatures; nonFeatures];
trainingLabels = [trainingLabels ; zeros(size(nonFeatures,1), 1)];
disp('Training SVM');
tic;
svm = fitcsvm(trainingFeatures(1:2:end,:), trainingLabels(1:2:end), ...
    'KernelFunction', 'rbf');
toc;
end