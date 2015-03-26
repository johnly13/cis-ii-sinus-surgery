close all;
I1 = imread(strcat('/Users/johnlee/Dropbox/Johns Hopkins/Computer Integrated Surgery II/recimg/rec-000098', '30', '.bmp'));
I2 = imread(strcat('/Users/johnlee/Dropbox/Johns Hopkins/Computer Integrated Surgery II/recimg/rec-000098', '31', '.bmp'));
[u, v] = HS(I1, I2, 12);
s = calcSmoothness(u,v,10);
figure;
imshow(s);
edges = findEdges(I2);
%imshow(s>mean(mean(s))&edges);