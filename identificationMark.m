inputnote = imread('2000-front-fake.png');
realnote = imread('2000-front-real.jpg');

inputnotegray = rgb2gray(inputnote);
realnotegray = rgb2gray(realnote);

cropinputnote = imcrop(inputnotegray,[2100 400 300 200]); 
croprealnote = imcrop(realnotegray,[2100 400 300 200]); 

inputnoteEdges = edge(cropinputnote, 'Roberts');
realnoteEdges = edge(croprealnote, 'Roberts');

correlationOutput = normxcorr2(inputnoteEdges, realnoteEdges);
threshold = 0.9;
maxValue = max(correlationOutput(:));
isIdMarkPresent = maxValue > threshold;

if isIdMarkPresent
    fprintf('The currency note is Real.\n');
else
    fprintf('The currency note is Fake.\n');
end
    
figure;
subplot(321), imshow(inputnote), title('Input Note');
subplot(322), imshow(realnote), title('Real Note');
subplot(323), imshow(cropinputnote), title('Input Identification Mark');
subplot(324), imshow(croprealnote), title('Real Identification Mark');
subplot(325), imshow(inputnoteEdges), title('Input Identification Mark (Edge Detection)');
subplot(326), imshow(realnoteEdges), title('Real Identification Mark (Edge Detection)');
