function detectFakeNote
    % Load pre-cropped latent mark and fake note
    latentMark = im2double(imread('r_f100_latent.jpg'));
    note = im2double(imread('100-front-fake.png'));

    % Set the correlation coefficient threshold
    correlationThreshold = 0.8;

    % Resize the detected note to a standard size
    standardSize = [940, 2060];
    resizedNote = imresize(note, standardSize);

    % Crop the region of interest (left bottom) from the detected note
    cropPosition = [50, 700];
    croppedNote = imcrop(resizedNote, [cropPosition, standardSize / 2]);

    % Detect latent mark in the cropped note
    [x_detect, y_detect, w_detect, h_detect, correlation_coefficient] = correlation(croppedNote, latentMark);

    % Display the results
    figure;

    subplot(1, 2, 1);
    imshow(note); % Show the original note
    title('Original Note');
    hold on;

    % Calculate the position of the rectangle on the original note
    x_original = x_detect + cropPosition(1);
    y_original = y_detect + cropPosition(2);

    if ~isempty(x_detect) && correlation_coefficient >= correlationThreshold
        title('Note with Latent Mark Detected (Authentic)');
    else
        title('Note without Latent Mark (Fake)');
    end
    hold off;

    subplot(1, 2, 2);
    imshow(croppedNote); % Show the cropped note
    title('Cropped Note');
    hold on;

    % Draw the rectangle on the cropped note
    if ~isempty(x_detect) && correlation_coefficient >= correlationThreshold
        rectangle('Position', [x_detect, y_detect, w_detect, h_detect], 'EdgeColor', 'r', 'LineWidth', 2);
    end
    hold off;
end

function [x, y, w, h, correlation_coefficient] = correlation(image, template)
    imageGray = rgb2gray(image);
    templateGray = rgb2gray(template);

    [ih, iw] = size(imageGray);
    [h, w] = size(templateGray);

    % Use a 2-dimensional array to record the difference of each position
    diffs = zeros(ih-h, iw-w);

    for i = 1:ih-h
        for j = 1:iw-w
            neighborhood = imageGray(i:i+h-1, j:j+w-1);
            difference = abs(neighborhood - templateGray);
            diffs(i, j) = sum(difference(:)) / (w*h);
        end
    end

    % Find the minimum difference value and its position
    [~, i] = min(diffs(:));
    [y, x] = ind2sub(size(diffs), i);

    % Calculate the correlation coefficient
    correlation_coefficient = 1 - diffs(i);

    disp(['Correlation Coefficient: ' num2str(correlation_coefficient)]);


    % Set width and height to the template size
    w = size(template, 2);
    h = size(template, 1);
end
