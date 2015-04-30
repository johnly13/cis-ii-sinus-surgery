scale = 25;
G4 = imresize(I, 1/scale);
G4 = imgradient(G4);
G4 = imresize(G4, scale, 'lanczos3');
imshow(G4);