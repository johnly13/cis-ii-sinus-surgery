%File name constants
%Make sure to change directory to cis-ii-sinus-surgery sandbox directory
close all;
imageHeader = 'rec-000098';
imageType = '.bmp';
labeledImageType = '.png';
outputHeader = fullfile('output');
inputHeader = fullfile('input');
I1 = imread(fullfile('input', strcat(imageHeader, '20', imageType)));
I2 = imread(fullfile('input', strcat(imageHeader, '22', imageType)));
labeled = imread(fullfile('input', strcat('labeled-', imageHeader, '20', labeledImageType))); 

% Train SVM on hand labeled image
trainingSetPoints = extractLearningSet(labeled);
[svm, trainingFeatures, trainingLabels] = trainSVM(I1, trainingSetPoints);

% Evaluate using a separate image
[features, edges] = extractFeatures(I2);
predictedLabels = predict(svm, features);

% Find features labeled with 1 (occluding contour)
edgeCoords = find(edges == 1);
featureEdgeCoords = find(predictedLabels == 1);
featureEdges = edgeCoords(featureEdgeCoords);
testFeatures = zeros(size(edges));
testFeatures(featureEdges) = 1;


% Find features labeled with 0 (not an occluding contour)
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

