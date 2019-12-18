function img_out = column_filter(img, win_size, fn_handle)
    radius = (win_size - 1)/2;
    [imgH, imgW] = size(img);
    img_out = zeros(1, imgH*imgW);
    index = 1;
    for j = 1:imgW
        for i = 1: imgH
            minI = max(1, i-radius);
            maxI = min(imgH, i+radius);
            minJ = max(i, j-radius);
            maxJ = min(imgW, j+radius);
            nbh = img(minI:maxI, minJ:maxJ);
            img_out(index) = fn_handle( nbh(:) );
            index = index + 1;
        end
    end
    img_out = reshape(img_out, imgH, imgW);
end
