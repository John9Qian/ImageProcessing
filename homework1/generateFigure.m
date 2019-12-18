function [img] = generateFigure(imgH ,imgW )
img = uint8(zeros(imgH,imgW,3));

x = 0: 2*pi/(imgW): 2*pi;
ry = sin(x);
gy = cos(x);
by = x.^2;

x = int32(x/2/pi*imgW + 1);
ry = int32(imgH - ry/2/pi*imgW);
gy = int32(imgH - gy/2/pi*imgW);
by = int32(imgH - by/2/pi*imgW);

for i=1: imgW
    if ry(i)>0 && ry(i) <= imgH
        img(ry(i), x(i), 1)=255;
    end
     if gy(i)>0 && gy(i) <= imgH
        img(gy(i), x(i), 2)=255;
     end
     if by(i)>0 && by(i) <= imgH
        img(by(i), x(i), 3)=255;
     end
end

imshow(img);
end