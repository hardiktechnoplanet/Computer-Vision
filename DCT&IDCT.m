clc;
clear all;
pkg load image
pkg load signal
Img=imread('iimg.jpg');
imshow(Img),title('Original Image');
Img=rgb2gray(Img);
figure,imshow(Img);title('Gray Scale Image');

[r,c]=size(Img);
DCT=zeros(r,c);
IDCT=DCT;
depth=4;
N=8; % we need to divide the image into 8x8 block

%dct=dct2(A);
%figure,imshow(dct),title('Original DCT');

for i=1:N:r
    for j=1:N:c
        block=Img(i:i+N-1,j:j+N-1); %8x8 block at which the operation is performed 
        dc=dct2(block);             %each block DCT
        DCT(i:i+N-1,j:j+N-1)=dc;    %DCT of blocks 
        
        dc(N:-1:depth+1,:) =0; % Preserve top 'x' rows of each block,value of x 
                               % can be set using the 'depth' variable   
        idc=idct2(dc);
        IDCT(i:i+N-1,j:j+N-1)=idc; %Inverse DCT of blocks 
    end
end

IDCT=uint8(IDCT);
figure;imshow(IDCT);title('IDCT Image for R=4');


        