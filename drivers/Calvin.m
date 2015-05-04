%Calvin Driver
close;
imageHeader = 'rec-000098';
imageType = '.bmp';
labeledImageType = '.png';
outputHeader = fullfile('output');
inputHeader = fullfile('input');
image1 = '20';
I1 = imread(fullfile('input', strcat(imageHeader, image1, imageType)));
I2 = imread(fullfile('input', strcat(imageHeader, '22', imageType)));
I3 = imread(fullfile('input', strcat(imageHeader, image1,'-edges', labeledImageType)));


figure;
red = I1(:,:,1);
red2 = I2(:,:,1);

%paramters
red_highC = imadjust(red,[0 0.7],[0 1]);
red_highC2 = imadjust(red2,[0 0.7],[0 1]);
thresh = .005;
filter = fspecial('gaussian', 20, 4);

edges = findEdges(red_highC, 0, 0, 0, filter, ...
    thresh, 0, 'Roberts');
false_points = I3(1:end,1:end,1) == 0 & ...
    I3(1:end,1:end,2) >= 254 & ...
    I3(1:end,1:end,3) >= 253;
false_edges = edges & false_points;
true_edges = edges & ~false_points;

edges2 = findEdges(red_highC2, 0, 0, 0, filter, ...
    thresh, 0, 'Roberts');


%% display
E = red_highC;
color = cat(3, zeros(size(E)), ones(size(E)), ones(size(E)));
imshow(I1, 'initialMag', 100);
hold on;
h = imshow(color); 
hold off
set(h, 'AlphaData', true_edges);

hold on
color = cat(3, ones(size(E)), zeros(size(E)), ones(size(E)));
h1 = imshow(color); 
set(h1, 'AlphaData', false_edges);

%output = mPb(red_highC,edges);

%% svm
%[svm, trainingFeatures, trainingLabels] = trainSVM2(red_highC, true_edges, false_edges);
% load('svm img20_2.mat');
% sv = svm.SupportVectors;
% figure
% gscatter(trainingFeatures(:,1),trainingLabels)
% hold on
% %plot(sv(:,1), sv(:,2),'ko','MarkerSize',10)
% legend('0','1','Support Vector')
% hold off
% 
% runSVM(red_highC,  edges, svm);