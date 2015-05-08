% svmTrainer.m
% Driver to train the SVM

%File name constants
%Make sure to change directory to cis-ii-sinus-surgery sandbox directory
close all;
imageHeader = 'rec-000098';
imageType = '.bmp';
labeledImageType = '.png';
outputHeader = fullfile('output');
inputHeader = fullfile('input');
N = 10;
xdim = 1280; ydim = 1024; nIchnl = 3; nLchnl = 1;
I = uint8(zeros(ydim,xdim,nIchnl,N));
L = uint8(zeros(ydim,xdim,nLchnl,N));
for i = 1:N
    imnum = 15 + 5*i;
    imstr = num2str(imnum);
    Itemp = imread(fullfile('input', strcat(imageHeader, imstr, imageType)));
    Ltemp = imread(fullfile('labeled', strcat('labeled-', imageHeader, imstr, labeledImageType)));
    I(:,:,:,i) = Itemp;
    L(:,:,:,i) = Ltemp;
end
I0 = imread(fullfile('input', strcat(imageHeader, '47', imageType)));

% Train SVM on hand labeled image
disp('Training on hand labeled image');
TSP = logical(zeros(ydim,xdim,N));
for i = 1:N
    TSP(:,:,i) = extractLearningSet(L(:,:,:,i));
end
[svm, trainingFeatures, trainingLabels] = trainSVM(I, TSP);

% Evaluate using a separate image
postTraining;

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

