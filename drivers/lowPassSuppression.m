% lowPassSuppression.m
% Driver to adjust image low intensity pixel values and compute basic edge
% detection

close all;
figure;
%Images 20-69
for i = 20:69
iString = num2str(i);
%I = imread(strcat('C:\Users\Turkey\Documents\MATLAB\CIS II Data\rec-000098', iString, '.bmp')); 
I = imread(strcat('/Users/johnlee/Dropbox/Johns Hopkins/Computer Integrated Surgery II/recimg/rec-000098', iString, '.bmp'));
grayIm = rgb2gray(I);
grayIm = im2double(grayIm);

%Tweak these parameters for preprocessing
%Default filter: Gaussian, 50, 15
filter = fspecial('gaussian', 50, 15);
lowPass = imfilter(grayIm, filter);
highPass = grayIm - lowPass;

%Tweak these parameters for preprocessing
%Default values: 2*high + 0.3*low + 0.3
procIm = 2.0*highPass + 0.3*lowPass + 0.3;

E = imcomplement(imcomplement([grayIm, procIm]));
color = cat(3, zeros(size(E)), ones(size(E)), ones(size(E)));

E = [grayIm, procIm];
% grayIm = imcomplement(grayIm);
% procIm = imcomplement(procIm);
imshow(E, 'initialMag', 100);
hold on;
h = imshow(color); 
hold off

%Tweak these parameters for edge detection
thresh = 0.00;
%Default sigma value: 10
sigma = 10; 
edgeType = 'canny';
edgesGray = edge(grayIm, edgeType, thresh, sigma);
edgesProc = edge(procIm, edgeType, thresh, sigma);
set(h, 'AlphaData', [edgesGray, edgesProc]);

pause(0.25)
end