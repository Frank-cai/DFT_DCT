clear;
clc;

%read image
img = imread('test3.jpg');

%convert to 2D
if ndims(img) == 3
    img = rgb2gray(img);
end
img = double(img);

%8x8 block DCT
Q = dctmtx(8);
blkDCT = blkproc(img,[8,8],'P1*x*P2',Q,Q');

%select low frequency
T = [1 1 1 1 1 1 0 0
     1 1 1 1 1 0 0 0
     1 1 1 1 0 0 0 0
     1 1 1 0 0 0 0 0
     1 1 0 0 0 0 0 0
     1 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0];
freqSelect = blkproc(blkDCT,[8,8],'P1.*x',T);

%8x8 block IDCT
IDCT = blkproc(freqSelect,[8,8],'P1*x*P2',Q',Q);

%display
figure(1)
    subplot(121);
    imshow(abs(img),[]),title('Original');
    subplot(122);
    imshow(abs(IDCT),[]),title('blkIDCT(frequency selected)');

