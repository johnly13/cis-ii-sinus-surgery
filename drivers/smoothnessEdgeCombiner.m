close all;

%File name constants
%Make sure to change directory to cis-ii-sinus-surgery sandbox directory
imageHeader = 'rec-000098';
imageType = '.bmp';
outputHeader = fullfile('output');
edgeHeader = fullfile(outputHeader, 'edges');
smoothHeader = fullfile(outputHeader, 'smoothness');
finalHeader = fullfile(outputHeader, 'final');
f = figure;

%Default 20:68
for i = 20:68
%Read in the images
iStr = num2str(i);
iNextStr = num2str(i+1);
I1 = imread(fullfile('input', strcat(imageHeader, iStr, imageType)));
I2 = imread(fullfile('input', strcat(imageHeader, iNextStr, imageType)));

%Preprocess images for HS
filter = fspecial('gaussian', 60, 20);

blur1 = imfilter(I1, filter);
blur2 = imfilter(I2, filter);

%Perform HS on blurred images
[u, v] = HS(blur1, blur2, 15);

%Calcuate smoothness based on optical flow
s = calcSmoothness(u, v, I1, I2, 15, 95);

%Combine edges from both image
edges = findEdges(I1) ;%| findEdges(I2);

%Output on screen and to disk

if mean(mean(s))/max(max(s)) > 0.037
    thresh = 0.09;
elseif mean(mean(s))/max(max(s)) < 0.02
    thresh = 0.0375;
else
    thresh = 0.052;
end
output = s ./ max(max(s)) > thresh & edges;

warning('off','all');
fprintf('%d: max: %f, mean: %f, mean/max: %f\n',i,  max(max(s)), mean(mean(s)), mean(mean(s))/max(max(s)));

%imwrite(edges, fullfile(edgeHeader, strcat(imageHeader, iStr,'-',iNextStr,imageType)));
%imwrite(s*20, fullfile(smoothHeader, strcat(imageHeader, iStr,'-',iNextStr,imageType)));

E = rgb2gray(I1);
color = cat(3, zeros(size(E)), ones(size(E)), ones(size(E)));
imshow(E, 'initialMag', 100);
hold on;
h = imshow(color); 
hold off
set(h, 'AlphaData', output);
saveas(f, fullfile(finalHeader, strcat(imageHeader, iStr,'-',iNextStr,imageType)));
% imwrite(output, fullfile(finalHeader, strcat(imageHeader, iStr,'-',iNextStr,imageType)));
pause(0.01);

end