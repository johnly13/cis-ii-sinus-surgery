close all;
warning('off','all');
tic;
imageHeader = 'rec-000098';
imageType = '.bmp';
for i = 20:69
    I0 = imread(fullfile('input', strcat(imageHeader, num2str(i), imageType)));
    % labeled0 = imread(fullfile('input', strcat('labeled-', imageHeader, '57', '.png')));
    disp('Evaluating...');
    [features, edges] = extractFeatures(I0);
    % trueFeatures = extractLearningSet(labeled0);

    predictedLabels = predict(svm, features);
    % Find features labeled with 1 (occluding contour)
    edgeCoords = find(edges == 1);
    featureEdgeCoords = find(predictedLabels == 1);
    featureEdges = edgeCoords(featureEdgeCoords);
    testFeatures = zeros(size(edges));
    testFeatures(featureEdges) = 1;

    % Find features labeled with 0 (not an occluding contour)
    % disp('Finding features labeled with 0');
    % nonFeatureEdgeCoords = find(predictedLabels == 0);
    % nonFeatureEdges = edgeCoords(nonFeatureEdgeCoords);
    % testNonFeatures = zeros(size(edges));
    % testNonFeatures(nonFeatureEdges) = 1;
    se = strel('disk',3);
    cls = imclose(bw,se);
    bw = bwareaopen(testFeatures,15);
    filename = strcat(imageHeader,num2str(i),'-edges',imageType);
    imwrite(bw, filename);
end
% d = imdilate(bw, se);
% for i = 1:1
% %     d = imdilate(d, se);
% end
% morph = bwmorph(d,'thin',inf);
% morph = bwmorph(morph, 'clean');
% trueDist = bwdist(trueFeatures);
% trueDist(~morph) = 0;
% avgDist = sum(sum(trueDist))/size(find(morph==1),1);

imshow([testFeatures bw]);
[normals,x,y] = getNorms(morph);
% figure;
% imshow(morph);
% hold on;
% xoff = -0.2:.1:0.2;
% for i = 1:length(normals)
%     xplot = x(i) + xoff;
%     yplot = normals(i).*xoff + y(i);
%     plot(xplot,yplot);
% end
% hold off;
title('Test Features vs. NonFeatures');
toc;