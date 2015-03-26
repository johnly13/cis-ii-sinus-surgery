imageHeader = 'rec-000098';
imageType = '.bmp';
outputHeader = fullfile('output');
edgeHeader = fullfile(outputHeader, 'edges');
smoothHeader = fullfile(outputHeader, 'smoothness');
finalHeader = fullfile(outputHeader, 'final');

edgeGif = fullfile(outputHeader, 'edges.gif');
smoothGif = fullfile(outputHeader, 'smoothness.gif');
finalGif = fullfile(outputHeader, 'final.gif');

delay = 0.3;

for i = 20:68
    iStr = num2str(i);
    iNextStr = num2str(i+1);
    I1 = imread(fullfile(edgeHeader, strcat(imageHeader, iStr,'-',iNextStr,imageType)));
    [A1, map1] = gray2ind(I1, 256);
    I2 = imread(fullfile(smoothHeader, strcat(imageHeader, iStr,'-',iNextStr,imageType)));
    [A2, map2] = gray2ind(I2, 256);
    I3 = imread(fullfile(finalHeader, strcat(imageHeader, iStr,'-',iNextStr,imageType)));
    [A3, map3] = rgb2ind(I3, 256);
    
	if i == 20
		imwrite(A1,map1,edgeGif,'gif','LoopCount',Inf,'DelayTime',delay);
		imwrite(A2,map2,smoothGif,'gif','LoopCount',Inf,'DelayTime',delay);
		imwrite(A3,map3,finalGif,'gif','LoopCount',Inf,'DelayTime',delay);
	else
		imwrite(A1,map1,edgeGif,'gif','WriteMode','append','DelayTime',delay);
        imwrite(A2,map2,smoothGif,'gif','WriteMode','append','DelayTime',delay);
		imwrite(A3,map3,finalGif,'gif','WriteMode','append','DelayTime',delay);

	end
end