% multiple linear dilations
function crop = cropImg(img, x, y, rad, mask)
    sz = size(img);
    if nargin < 2
        x = floor(sz(2)/2);
        y = floor(sz(1)/2);
        rad = 8;
        mask = uint8(fspecial('disk',rad)~=0);
    elseif nargin == 4
        mask = uint8(fspecial('disk',rad)~=0);       
    end
    x0 = x - rad;
    x1 = x + rad;
    y0 = y - rad;
    y1 = y + rad;
    

    if isa(mask,'uint8')
        mat = uint8(zeros(2*rad + 1));
    else
        mat = zeros(2*rad + 1);
    end
    
    if x0 < 1 && y0 < 1
        xoff = -x0 + 1;
        yoff = -y0 + 1;
        mat(yoff+1:end,xoff+1:end) = img(1:y1,1:x1);
    elseif x0 < 1 && y1 > sz(1)
        xoff = -x0 + 1;
        yoff = -(y1 - sz(1));
        mat(1:end+yoff,xoff+1:end) = img(y0:end,1:x1);
    elseif y0 < 1 && x1 > sz(2)
        xoff = -(x1 - sz(2));
        yoff = -y0 + 1;
        mat(yoff+1:end,1:end+xoff) = img(1:y1,x0:end);
    elseif x1 > sz(2) && y1 > sz(1)
        xoff = -(x1 - sz(2));
        yoff = -(y1 - sz(1));
        mat(1:end+yoff,1:end+xoff) = img(y0:end,x0:end);
    elseif x0 < 1
        xoff = -x0 + 1;
        mat(1:end,xoff + 1:end) = img(y0:y1,1:x1);
    elseif y0 < 1
        yoff = -y0 + 1;
        mat(yoff + 1:end,1:end) = img(1:y1,x0:x1);
    elseif x1 > sz(2)
        xoff = -(x1 - sz(2));
        mat(1:end,1:end + xoff) = img(y0:y1,x0:end);
    elseif y1 > sz(1)
        yoff = -(y1 - sz(1));
        mat(1:end + yoff,1:end) = img(y0:end,x0:x1);
    else
        mat = img(y0:y1,x0:x1);
    end
    crop = mat.*mask;
end