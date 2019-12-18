# 图像处理

1. n使用matlab写一个函数，`img = generateFigure(imgW,imgH)`，其作用为产生一幅的彩色图像，图像中用红色显示 [0,2*pi] 的正弦波，用绿色显示[0,2*pi]的余弦波，蓝色显示[0,2*pi]的y=x^2图像。

   代码实现：

   ```matlab
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
   end`
   ```

   在命令行执行：`generateFigure(imgH,imgW)`

   即可加载出高度为`imgH`，宽度为`imgW`的彩色图像，图像中用红色显示 [0,2*pi] 的正弦波，用绿色显示[0,2*pi]的余弦波，蓝色显示[0,2*pi]的y=x^2图像。

   如命令行执行`generateFigure(600, 800)`产生的结果为：

   <img src="C:\Users\qbb19\AppData\Roaming\Typora\typora-user-images\1573719254548.png" alt="1573719254548" style="zoom: 50%;" />

   背景的颜色为黑色，右下角的位置为（0，0）点，宽度为0~2pi，高度的坐标尺，与宽度相同（产生的蓝线不太明显）

   

2. 不使用for循环，实现bilinear interpolation

   使用while循环实现bilinear interpolation,函数名为`bilinearInterpolation(k)`

   代码实现如下：

   ``` function []=bilinearInterpolation(k)
   img=imread('picture.jpg');
   imshow(img);
   img=double(img);
   [rows, cols, color]=size(img);
   x_new=round(rows*k);
   y_new=round(cols*k);
   %缩放至k倍
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
   ```

   在命令行执行：`bilinearInterpolation(k)`，即可将所给的示例图片放大k倍

   在命令行执行`bilinearInterpolation(1)`效果为：
   
   <img src="C:\Users\qbb19\AppData\Roaming\Typora\typora-user-images\1573725535968.png" alt="1573725535968" style="zoom:50%;" /> 
   
   在命令行执行`bilinearInterpolation(0.5)` 效果为：
   
   <img src="C:\Users\qbb19\AppData\Roaming\Typora\typora-user-images\1573725610502.png" alt="1573725610502" style="zoom:50%;" />

