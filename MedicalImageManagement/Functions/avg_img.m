function out_img = avg_img(img);
    sz = size(img);
    temp_out_img = zeros(sz(1),sz(2));
    
    for i = 1:size(img, 3)
        temp_out_img = temp_out_img + img(:,:,i);
    end
    out_img = temp_out_img./sz(3);
    
end
