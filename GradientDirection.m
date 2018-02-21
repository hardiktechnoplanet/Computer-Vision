%Gradient direction
pkg load image;

function result=select_gdir(gmag,gdir,mag_min,angle_low,angle_high)
  result = gmag >=mag_min & angle_low <=gdir & gdir <=angle_high;
  endfunction

%Load and convert image to double type, range [0,1] for convenience
img=double(imread('octagon.png'))/255.; %it is divided by 255 to scale down to 
                                        %[0 1] range
imshow(img);

%compute x, y gradient, 'imgradientxy' function returns gradient in x dicrection
%'gx' and gradient in y direction 'gy'. Default filter is used as 'sobel'.
[gx gy]=imgradientxy(img,'sobel');
%imgradientxy function does not normalize, so divide by 8. If there is an image
%such that the left side is black and right side is white, the result will be in
%range [-4 4]. If we add 4 to these values, the range shifts to [0 8], divide by
% 8 shifts the range to [0 1] and it is the desired range.
imshow((gx+4)/8); %it will display the vertical edges
imshow((gy+4)/8); %it will display the horizontal edges

%obtain gradient magniture and direction
[gmag gdir]=imgradient(gx,gy);
imshow(gmag/(4*sqrt(2))); %gmag =sqrt(gx^2+gy^2), so:[0, (4*sqrt(2))]
imshow((gdir+180.0)/360.0); %angle in degrees [-180 +180]

%Find pixels with desired gradient values
%in the function below, the third parameter indicates the min magniture value we
%want to consider to remove some noise that takes the pixel value to a very lower
%level, the 4th and 5th arguments tells the desired gradient range, its 45 with 
%+/-15
my_grad=select_gdir(gmag,gdir,1,30,60);
imshow(my_grad);