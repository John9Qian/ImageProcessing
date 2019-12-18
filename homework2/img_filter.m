function img_out = img_filter(img, win_size, filt_type, varigin)
    switch(filt_type)
        case 'arithmetic_mean'
            img_out = column_filter(img, win_size, @mean);
        case 'geometric_mean'
            img_out = column_filter(log(img), win_size, @mean);
            img_out = exp(img_out);
        case ' harmonic_mean'
            img_out = column_filter(1./img, win_size, @sum);
            img_out = win_size*win_size./img_out;
        case 'contra_harmonic_mean'
            p = varigin{1};
            img_out1 = column_filter(img.^(p+1), win_size, @sum);
            img_out2 = column_filter(img.^p, win_size, @sum);
            img_out = img_out1./img_out2;
        case 'midian_filter'
            img_out = column_filter(img, win_size, @median);
        case 'max_filter'
            img_out = column_filter(img, win_size, @max);
        case 'min_filter'
            img_out = column_filter(img, win_size, @max);
        otherwise
            error('Wrong input!')
    end
end