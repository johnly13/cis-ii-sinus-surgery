% calcSmoothness.m
% Calculates smoothness from optical flow vectors
% INPUT:
% u = x-direction optical flow vector
% v = y-direction optical flow vector
% I1 = first image
% I2 = second image
% w = width
% intThresh = threshold
% OUTPUT:
% s = smoothness map

function s = calcSmoothness(u, v, I1, I2, w, intThresh)
if nargin == 4
    w = 5;
end

if nargin < 6 && nargin >= 4
    intThresh = 90;       
end

if size(u) ~= size(v)
    error('u and v must be the same size');
end
if size(I1,3) == 3
    I1 = rgb2gray(I1);
end
if size(I2,3) == 3
    I2 = rgb2gray(I2);
end

if mod(w, 2) == 0
    w = w + 1;
end
%     
% lbHalf = floor(w/2);
% if mod(w, 2) == 0
%     ruHalf = w/2 - 1;
% else
%     ruHalf = floor(w/2);
% end
% s = zeros(size(u));
% su = zeros(w^2, (size(u,1)-2*w)*(size(u,2)-2*w));
% sv = zeros(w^2, (size(u,1)-2*w)*(size(u,2)-2*w));
% count = 1;
% for i = 1+lbHalf:size(u,1)-ruHalf
%     for j = 1+lbHalf:size(u,2)-ruHalf
%         if I1(i,j) > intThresh || I2(i,j) > intThresh
%             su(1:end, count) = zeros(w^2,1);
%             sv(1:end, count) = zeros(w^2,1);
%         else
%             su(1:end, count) = reshape(u(i-lbHalf:i+ruHalf,j-lbHalf:j+ruHalf), [w^2,1]);
%             sv(1:end, count) = reshape(v(i-lbHalf:i+ruHalf,j-lbHalf:j+ruHalf), [w^2,1]);
%         end
%         count = count + 1;
%     end
% end




% sAngle = atan(sv./su);
% sAngle = reshape(var(sAngle./max(max(sAngle))), [j-lbHalf, i-lbHalf])';
% sMag = sqrt(su.^2+sv.^2);
% sMag = reshape(var(sMag./max(max(sMag))), [j-lbHalf, i-lbHalf])';
% s2(1+lbHalf:size(u,1)-ruHalf, 1+lbHalf:size(u,2)-ruHalf) = (sAngle+sMag)/2;
% su = reshape(var(su), [j-lbHalf, i-lbHalf])';
% sv = reshape(var(sv), [j-lbHalf, i-lbHalf])';
% s(1+lbHalf:size(u,1)-ruHalf, 1+lbHalf:size(u,2)-ruHalf) = (su+sv)/2;

su = stdfilt(u, ones(w));
sv = stdfilt(v, ones(w));
mask = I1 < intThresh & I2 < intThresh;

s = (su + sv)/2.*mask;

end

