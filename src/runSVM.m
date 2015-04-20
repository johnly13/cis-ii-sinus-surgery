function [svm, trainingFeatures, trainingLabels] = runSVM(I, edges, svm)
%piece of svmTrainer

% Evaluate using a separate image
%[features, edges] = extractFeatures2(I, I_edges);
load('multiPb img20.mat');
features = multiPb(edges);
predictedLabels = predict(svm, features);

figure;
% Find features labeled with 1 (occluding contour)
edgeCoords = find(edges == 1);
featureEdgeCoords = find(predictedLabels == 1);
featureEdges = edgeCoords(featureEdgeCoords);
testFeatures = zeros(size(edges));
testFeatures(featureEdges) = 1;
imshow(testFeatures);

% Find features labeled with 0 (not an occluding contour)
nonFeatureEdgeCoords = find(predictedLabels == 0);
nonFeatureEdges = edgeCoords(nonFeatureEdgeCoords);
testNonFeatures = zeros(size(edges));
testNonFeatures(nonFeatureEdges) = 1;
imshow(testNonFeatures);

figure;
% Visualize trainingSetPoints and edges
E = I;
color = cat(3, zeros(size(E)), ones(size(E)), ones(size(E)));
imshow(I, 'initialMag', 100);
hold on;
h = imshow(color); 
hold off
set(h, 'AlphaData', trainingSetPoints);

hold on
color = cat(3, ones(size(E)), zeros(size(E)), ones(size(E)));
h1 = imshow(color); 
set(h1, 'AlphaData', edges);
edges = E(svm>=1);

imshow(imfuse(testFeatures, testNonFeatures));