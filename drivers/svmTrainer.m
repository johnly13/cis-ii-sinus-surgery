tic;
%File name constants
%Make sure to change directory to cis-ii-sinus-surgery sandbox directory
close all;
imageHeader = 'rec-000098';
imageType = '.bmp';
labeledImageType = '.png';
outputHeader = fullfile('output');
inputHeader = fullfile('input');
I1 = imread(fullfile('input', strcat(imageHeader, '20', imageType)));
I2 = imread(fullfile('input', strcat(imageHeader, '47', imageType)));
I3 = imread(fullfile('input', strcat(imageHeader, '69', imageType)));
I0 = imread(fullfile('input', strcat(imageHeader, '35', imageType)));
labeled1 = imread(fullfile('input', strcat('labeled-', imageHeader, '20', labeledImageType)));
labeled2 = imread(fullfile('input', strcat('labeled-', imageHeader, '47', labeledImageType)));
labeled3 = imread(fullfile('input', strcat('labeled-', imageHeader, '69', labeledImageType)));

% Train SVM on hand labeled image
disp('Training on hand labeled image');
trainingSetPoints1 = extractLearningSet(labeled1);
trainingSetPoints2 = extractLearningSet(labeled2);
trainingSetPoints3 = extractLearningSet(labeled3);
[svm, trainingFeatures, trainingLabels] = trainSVM(I1, I2, I3, trainingSetPoints1, trainingSetPoints2, trainingSetPoints3);

% Evaluate using a separate image
disp('Evaluating using separate image');
[features, edges] = extractFeatures(I0);
predictedLabels = predict(svm, features);

% Find features labeled with 1 (occluding contour)
disp('Finding features labeled with 1');
edgeCoords = find(edges == 1);
featureEdgeCoords = find(predictedLabels == 1);
featureEdges = edgeCoords(featureEdgeCoords);
testFeatures = zeros(size(edges));
testFeatures(featureEdges) = 1;


% Find features labeled with 0 (not an occluding contour)
disp('Finding features labeled with 0');
nonFeatureEdgeCoords = find(predictedLabels == 0);
nonFeatureEdges = edgeCoords(nonFeatureEdgeCoords);
testNonFeatures = zeros(size(edges));
testNonFeatures(nonFeatureEdges) = 1;
figure;
imshow([testFeatures, testNonFeatures]);
title('Test Features vs. NonFeatures');

% Visualize support vectors
% sv = svm.SupportVectors;
% figure
% gscatter(trainingFeatures(:,1), trainingFeatures(:,2),trainingLabels)
% hold on
% plot(sv(:,1), sv(:,2),'ko','MarkerSize',10)
% legend('0','1','Support Vector')
% hold off

% Visualize trainingSetPoints and edges
% E = rgb2gray(I);
% color = cat(3, zeros(size(E)), ones(size(E)), ones(size(E)));
% imshow(I, 'initialMag', 100);
% hold on;
% h = imshow(color); 
% hold off
% set(h, 'AlphaData', trainingSetPoints);

% hold on
% color = cat(3, ones(size(E)), zeros(size(E)), ones(size(E)));
% h1 = imshow(color); 
% set(h1, 'AlphaData', edges);
% edges = E(svm>=1);

toc