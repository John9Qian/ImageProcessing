function []=bilinearInterpolation(k)
img=imread('picture.jpg');
imshow(img);
img=double(img);
[rows, cols, color]=size(img);
x_new=round(rows*k);
y_new=round(cols*k);
%Àı∑≈÷¡k±∂
I_new=zeros(x_new,y_new);
rgb = 0;
while rgb < color
    rgb = rgb + 1;
    for i=1:x_new
        for j=1:y_new
            x=i/k;
            a=floor(x);
            y=j/k;
            b=floor(y);
            if a>0 && b>0 && a<rows && b<cols
                cxb=img(a+1,b,rgb)*(x-a)+img(a,b,rgb)*(1+a-x);
                cxb1=img(a+1,b+1,rgb)*(x-a)+img(a,b+1,rgb)*(1+a-x);
                I_new(i,j,rgb)=round(cxb1*(y-b)+cxb*(1+b-y));
            end
        end
    end
end
imshow(uint8(I_new));
end