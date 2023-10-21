img = imread("cameraman.tif");
%% Smoothing and Sharpening
smoothingFilterA = 1/9*[1,1,1;
    1,1,1;
    1,1,1];
smoothingFilterB = 1/10*[1,1,1;
    1,2,1;
    1,1,1];
smoothingFilterC = 1/16*[1,2,1;
    2,4,2;
    1,2,1];

% Apply the smoothing filter using convolution
smoothingImgA = conv2(double(img), smoothingFilterA, 'same');
smoothingImgB = conv2(double(img), smoothingFilterB, 'same');
smoothingImgC = conv2(double(img), smoothingFilterC, 'same');

% Display the original and smoothed images
subplot(1,4,1);
imshow(img);
title('Original Image');

subplot(1,4,2);
imshow(uint8(smoothingImgA));
title('Smoothing Filter A');

subplot(1,4,3);
imshow(uint8(smoothingImgB));
title('Smoothing Filter B');

subplot(1,4,4);
imshow(uint8(smoothingImgC));
title('Smoothing Filter C');

%% Convolution and Correlation
%{
H = [1 2 3
     4 5 6
     7 8 9];
H = H/45;
Filter_correlation = imfilter(img,H); %by default the filtering is done using correlation
Filter_convolution = imfilter(img,H,"conv"); %this performs filtering using convolution

subplot(1,3,1);
imshow(img);
title('Original Image');

subplot(1,3,2);
imshow(Filter_convolution);
title('Filter Convolution');

subplot(1,3,3);
imshow(Filter_correlation);
title('Filter Correlation');
%}

%% Using fspecial to create different filters
%{
H1 = fspecial('sobel');
EdgeSobel = imfilter(img,H1);

H2 = fspecial('unsharp');
SharpImg = imfilter(img,H2);

subplot(1,3,1);
imshow(img);
title('Original Image');

subplot(1,3,2);
imshow(EdgeSobel);
title('Edge Sobel');

subplot(1,3,3);
imshow(Filter_correlation);
title('Unsharp');
%}

%% imnoise & fspecial & filter2
%{
I = imread('rice.png');
J = imnoise(I,'salt & pepper', 0.02);
K = fspecial('average');
J1 = filter2(K,J);
subplot(1,3,1);
imshow(I);
title('Original Image');

subplot(1,3,2);
imshow(J);
title('Edge Sobel');

subplot(1,3,3);
imshow(uint8(J1));
title('Unsharp');
%}

%% Without using imadd/imsubtract, we can 
% perform the arithmetic point processing as below:
% Note: Here we have to perform typecasting (converting to double, converting to uint8)

% Brightness Enhancement
%{
BrightImg = double(img) + 50;
subplot(1,2,1);
imshow(img);
title('Original Img');
subplot(1,2,2);
imshow(uint8(BrightImg));
title('Bright Img');
%}

%% fspecial, filter motion, horizontal edge-detection (sobel)
%{
cat = imread('cat_orig.png');
subplot(1,4,1);
imshow(cat);
title("Original Image");

% motion blur
h = fspecial('motion',20,45);
cat_motion = imfilter(cat,h);
subplot(1,4,2);
imshow(cat_motion);
title("Cat Motion Img");

% sharpening
h = fspecial('unsharp');
cat_sharp = imfilter(cat,h);
subplot(1,4,3);
imshow(cat_sharp);
title("Cat Sharp Img");

% horizontal edge-detection
h = fspecial('sobel');
cat_sobel = imfilter(cat,h);
subplot(1,4,4);
imshow(cat_sobel);
title("Cat edge detect Img");
%}

%% Averaging and median filter
circuitBoard = imread('circuit_board.png');

% Check if the image is in RGB format
%{
if size(circuitBoard, 3) == 3
    % Convert RGB image to grayscale
    circuitBoard_gray = rgb2gray(circuitBoard);
else
    % Image is already grayscale
    circuitBoard_gray = circuitBoard;
end

circuitBoard_double = im2double(circuitBoard_gray);
h = ones(3,3)/(3^2);
circuitBoard_filtered = conv2(circuitBoard_double, h, 'same');
circuitBoard_Median = medfilt2(circuitBoard_double, [3 3]);

subplot(1,3,1);
imshow(circuitBoard);
title("Original Img");

subplot(1,3,2);
imshow(circuitBoard_filtered);
title("3x3 Smoothing Filter");

subplot(1,3,3);
imshow(circuitBoard_Median);
title("3x3 Median Filter");
%}


