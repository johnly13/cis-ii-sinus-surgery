% labelDriver.m
% Exports basic edge detection images

close;
imageHeader = 'rec-000098';
imageType = '.bmp';
labeledImageType = '.png';
outputHeader = fullfile('output');
inputHeader = fullfile('input');
image = '20';

I1 = imread(fullfile('input', strcat(imageHeader, image, imageType)));
filter = fspecial('gaussian',20,4);
I1 = imfilter(I1,filter);
red = I1(:,:,1);

red_highC = imadjust(red,[0 0.7],[0 1]);

thresh = .000;

edges = findEdges(red_highC, 0, 0, 0, fspecial('gaussian', 20, 4), ...
    thresh, 0, 'Canny');

imshow( edges);
%imwrite(imfuse(red_highC,edges), fullfile(strcat(imageHeader, image,'-edges',imageType)));