%Calvin Driver
close;
imageHeader = 'rec-000098';
imageType = '.bmp';
labeledImageType = '.png';
outputHeader = fullfile('output');
inputHeader = fullfile('input');
image = '20';

I1 = imread(fullfile('input', strcat(imageHeader, image, imageType)));

red = I1(:,:,1);

red_highC = imadjust(red,[0 0.7],[0 1]);

thresh = .005;

edges = findEdges(red_highC, 0, 0, 0, fspecial('gaussian', 20, 4), ...
    thresh, 0, 'Roberts');

imshow(imfuse(red_highC, edges));
%imwrite(imfuse(red_highC,edges), fullfile(strcat(imageHeader, image,'-edges',imageType)));