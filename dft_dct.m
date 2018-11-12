clc;
clear;

%read image
img = imread('test1.jpg');

%two dimensions
if ndims(img) == 3
   img = rgb2gray(img);
end

%get the size of the image
[m,n] = size(img);

img = double(img);

%move low frequency point to the center
F = zeros(m,n);
for i = 1:m
    for j = 1:n
       F(i,j) = img(i,j);
       if(rem(i+j,2) ~= 0)
           F(i,j) = 0-F(i,j);
       end      
    end
end

%DFT
W1 = zeros(m,m);
for i = 1:m
    for j = 1:m
        W1(i,j) = exp(-2*pi*(i-1)*(j-1)*complex(0,1)/m);
    end
end
W2 = zeros(n,n);
for i = 1:n
    for j = 1:n
        W2(i,j) = exp(-2*pi*(i-1)*(j-1)*complex(0,1)/n);
    end
end
DFT = W1*F*W2;

%IDFT
W1 = zeros(m,m);
for i = 1:m
    for j = 1:m
        W1(i,j) = exp(2*pi*(i-1)*(j-1)*complex(0,1)/m);
    end
end
W2 = zeros(n,n);
for i = 1:n
    for j = 1:n
        W2(i,j) = exp(2*pi*(i-1)*(j-1)*complex(0,1)/n);
    end
end
IDFT = W1*DFT*W2;
IDFT = IDFT/m/n;

%DCT
A1 = zeros(m,m);
for i = 1:m
    for j = 1:m
        A1(i,j) = sqrt(2/m)*cos((j-0.5)*pi*(i-1)/m);
        if i == 1
            A1(i,j) = 1/sqrt(2)*A1(i,j);
        end
    end
end

A2 = zeros(n,n);
for i = 1:n
    for j = 1:n
        A2(i,j) = sqrt(2/n)*cos((j-0.5)*pi*(i-1)/n);
        if i == 1
            A2(i,j) = A2(i,j)/sqrt(2);
        end
    end
end

DCT=A1*img*A2;

%IDCT
A1=A1';
A2=A2';
IDCT=A1*DCT*A2;

%display
figure(1)
    subplot(231);
    imshow(img,[]);
    subplot(232);
    imshow(1+log(abs(DFT)),[]);title("DFT");
    subplot(233);
    imshow(abs(IDFT),[]);title("IDFT");
    subplot(234);
    imshow(img,[]);
    subplot(235);
    imshow(1+log(abs(DCT)),[]);title("DCT");
    subplot(236);
    imshow(abs(IDCT),[]);title("IDCT");


