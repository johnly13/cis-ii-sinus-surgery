function edges = findEdges(I, lowPassFactor, highPassFactor, boost, ...
    filter, thresh, sigma, edgeType)

if nargin == 1
   lowPassFactor = 0.3;
   highPassFactor = 2;
   boost = 0.3;
   filter = fspecial('gaussian', 25, 15);
   thresh = 0.005;
   sigma = 10;
   edgeType = 'Roberts';
end
I = imfilter(I, filter);
if size(I,3) == 3
    grayIm = rgb2gray(I);
else
    grayIm = I;
end
grayIm = im2double(grayIm);

%Tweak these parameters for preprocessing
%Default filter: Gaussian, 50, 15
%lowPass = imfilter(grayIm, filter);
%highPass = grayIm - lowPass;

%Tweak these parameters for preprocessing
%Default values: 2*high + 0.3*low + 0.3
%procIm = highPassFactor*highPass + lowPassFactor*lowPass + boost;
procIm = medfilt2(grayIm, [15 15]);

%Tweak these parameters for edge detection
%Default threshold: 0
%Default sigma value: 10

edges = edge(procIm, edgeType);%, thresh);%, sigma);
end