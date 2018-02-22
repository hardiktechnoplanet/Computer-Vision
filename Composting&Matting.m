% COMPOSITION & MATTING
%this code cuts a foreground object from one scene and put it on the top of 
%a different background.  
clc;
clear all;
pkg load image
I1=imread('background.jpg'); %read background image
I1=im2double(I1);
imshow(I1);title('Background Image'); 
I2=imread('foreground.jpg'); %read foreground image
I2=im2double(I2);
figure;imshow(I2);title('Foreground Image');

[r,c,l]=size(I1);
C=r/2;

alpha(r,c)=zeros();
for i=1:r
    for j=1:c
        distance=sqrt(((C-i)^2)+((C-j)^2));
        %All pixels with a distance from the center of the image equal to less 
        %than C/2 are equal to 1.
        if(distance<(C/2))
            alpha(i,j)=1;
        %All pixels with a distance from the center of the image equal to more 
        %than C are equal to 0.
        elseif(distance>C)
            alpha(i,j)=0;
        %All pixels in between have a decreasing value from 1 to 0 as the 
        %distance from the center of the image increases.
        else
            alpha(i,j)=(C-distance)/100;
        end
    end
end
figure;imshow(alpha);title('Alpha Image');

%Effect of Composting and Matting
Component(r,c,l)=zeros();
for k=1:l
        Component(:,:,k)=(((1-alpha).*I1(:,:,k))+(alpha.*I2(:,:,k)));
end
figure;imshow(Component);title('Alpha Matted Image'); %Alpha-Matted image
