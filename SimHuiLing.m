%% Morphology + template matching

% Load the Rupee 2000 image
inputImg = imread('r_f2000.jpg');

% Convert image to grayscale
inputImgGray = rgb2gray(inputImg);

% Apply morphological operations (erosion)
se = strel('line', 5, 90);  % Create a vertical line structuring element
erodedImg = imerode(inputImgGray, se);  % Erosion using the same structuring element

% Set the region of interest (replace with your provided values)
x = round(1308.9737);
y = round(127.07127);
width = round(88.4813);
height = round(734.8448);

% Crop the eroded image to the selected region
croppedImage = imcrop(erodedImg, [x, y, width, height]);

% Create a new image with the same size as the original eroded image
newImage = uint8(zeros(size(erodedImg)));

% Get the size of the cropped region
[heightCropped, widthCropped, ~] = size(croppedImage);

% Place the cropped region in the new image
newImage(y:y+heightCropped-1, x:x+widthCropped-1, :) = croppedImage;

% Save the cropped image
imwrite(newImage, 'eroded_input.jpg');

% Load the template image for the security thread
templateFileName = 'template_2000.jpg';
template = imread(templateFileName);

% Convert the template image to grayscale if it is in RGB format
if size(template, 3) == 3
    templateGray = rgb2gray(template);
else
    templateGray = template; % Assume the image is already in grayscale
end

% Convert the eroded image to grayscale
erodedImgGray = erodedImg;

% Perform template matching using SSD on the eroded image
ssdMapResult = (double(templateGray) - double(erodedImgGray)).^2;
ssdResult = sum(ssdMapResult(:));

% Set a threshold for matching (you can adjust this threshold)
realCurrencySSDResult = 77879205449;
threshold = 1e8; % Adjust based on your observations

% Determine whether it's a match or not
if abs(ssdResult - realCurrencySSDResult) < threshold
    resultMessage = 'It is real currency!';
else
    resultMessage = 'It is fake currency!';
end

% Display the result
figure;
subplot(3, 1, 1);
imshow(inputImgGray);
title('Input Image');

subplot(3, 1, 2);
imshow(erodedImg);
title('Eroded Image');

subplot(3, 1, 3);
imshow(ssdMapResult, []);
title(['SSD Map (Result: ' num2str(ssdResult) ') - ' resultMessage]);