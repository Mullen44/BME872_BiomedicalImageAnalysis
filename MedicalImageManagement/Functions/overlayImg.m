function output_value = overlayImg(img,overlay_img, RGB, Transparency_Value)

[rows, columns,depth] = size(img);

for i=1:depth
    org = img(:,:,i);
    masked = overlay_img(:,:,i);
    masked = masked - min(min(min(masked)));
    masked = masked./max(max(max(masked)));
    masked = masked.*Transparency_Value;
%create image of red
image=zeros(512,512,3);
image(:,:,1) = RGB(1);   %red
image(:,:,2) = RGB(2);
image(:,:,3) = RGB(3); 
imshow(image)
colorbar;

%start
imshow(org,[])
hold on
h =imshow(image);
hold off
set(h, 'AlphaData', masked);
end
output_value = 1;

end