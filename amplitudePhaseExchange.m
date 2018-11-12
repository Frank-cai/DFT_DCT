clc;
clear;

%read image
img1 = imread('test1.jpg');
img2 = imread('test2.jpg');

%convert to 2D
if ndims(img1) == 3
   img1 = rgb2gray(img1);
end
if ndims(img2) == 3
   img2 = rgb2gray(img2);
end

%DFT
fft1 = fft2(img1);
fft2 = fft2(img2);

%get amplitude
amp1 = abs(fft1);
amp2 = abs(fft2);

%get phase
phase1 = angle(fft1);
phase2 = angle(fft2);

%exchange amplitude and phase
exAmp1 = amp2.*cos(phase1)+amp2.*sin(phase1).*complex(0,1);
exAmp2 = amp1.*cos(phase2)+amp1.*sin(phase2).*complex(0,1);

%IDFT
ifft1 = abs(ifft2(exAmp1));
ifft1 = uint8(ifft1);
ifft2 = abs(ifft2(exAmp2));
ifft2 = uint8(ifft2);

%display
figure(1)
    subplot(221);
    imshow(img1,[]);title('img1');
    subplot(223);
    imshow(ifft1);title('phase1-amp2');
    subplot(222);
    imshow(img2,[]);title('img2');
    subplot(224);
    imshow(ifft2);title('phase2-amp1');
    