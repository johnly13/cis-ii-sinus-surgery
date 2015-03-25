function s = calcSmoothness(u, v, w)
if nargin == 2
    w = 5;
end
if size(u) ~= size(v)
    error('u and v must be the same size');
end
lbHalf = floor(w/2);
if mod(w, 2) == 0
    ruHalf = w/2 - 1;
else
    ruHalf = floor(w/2);
end
s = zeros(size(u));
su = zeros(w^2, (size(u,1)-2*w)*(size(u,2)-2*w));
sv = zeros(w^2, (size(u,1)-2*w)*(size(u,2)-2*w));
count = 1;
for i = 1+lbHalf:size(u,1)-ruHalf
    for j = 1+lbHalf:size(u,2)-ruHalf
        su(1:end, count) = reshape(u(i-lbHalf:i+ruHalf,j-lbHalf:j+ruHalf), [w^2,1]);
        sv(1:end, count) = reshape(v(i-lbHalf:i+ruHalf,j-lbHalf:j+ruHalf), [w^2,1]);
        count = count + 1;
    end
end
% sAngle = atan(sv./su);
% sAngle = reshape(var(sAngle./max(max(sAngle))), [j-lbHalf, i-lbHalf])';
% sMag = sqrt(su.^2+sv.^2);
% sMag = reshape(var(sMag./max(max(sMag))), [j-lbHalf, i-lbHalf])';
% s2(1+lbHalf:size(u,1)-ruHalf, 1+lbHalf:size(u,2)-ruHalf) = (sAngle+sMag)/2;
su = reshape(var(su), [j-lbHalf, i-lbHalf])';
sv = reshape(var(sv), [j-lbHalf, i-lbHalf])';
s(1+lbHalf:size(u,1)-ruHalf, 1+lbHalf:size(u,2)-ruHalf) = (su+sv)/2;

end

