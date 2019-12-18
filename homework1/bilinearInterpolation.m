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
    i = 0;
    while i < x_new
        i = i + 1;
        j = 0;
        while j < y_new
            j = j + 1;
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


% function outImg = bilinearInterpolation(img, factor)
%     [imgH, imgW] = size(img);
%     
%     destH = round(imgH*factor);
%     destW = round(imgW*factor);
%     [X, Y] = meshgrid(1:destW, 1:destH);
%     X_f = (X-1)/(destH-1)*(imgH-1) + 1;
%     Y_f = (Y-1)/(destW-1)*(imgW-1) + 1;
%     
%     du = X_f - floor(X_f);
%     dv = Y_f - floor(Y_f);
%     A_X = floor(X_f);
%     A_Y = floor(Y_f);
%     indexA = A_Y + (A_X-1)*imgH;
%     D_X = floor(X_f) + (du > 0);
%     D_Y = floor(Y_f) + (dv > 0);
%     indexD = D_Y + (D_X-1)*imgH;
%     indexB = A_Y + (D_X-1)*imgH;
%     indexC = D_Y + (A_X-1)*imgH;
%     outImg = (1-du).*(1-dv).*img(indexA)+ (1-dv).*du.*img(indexB)+(1-du).*dv.*img(indexC)+du.*dv.*img(indexD);
%     
%     
%     
% end
