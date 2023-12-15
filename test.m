function currencyRecognitionGUI
    % Create a figure for the GUI
    fig = figure('Position', [100, 100, 600, 400], 'Name', 'Currency Recognition', 'NumberTitle', 'off', 'Menubar', 'none');

    % Create a button to select an image
    uicontrol('Style', 'pushbutton', 'String', 'Select Image', 'Position', [20, 20, 100, 30], 'Callback', @openImage);

    % Create an axis to display the result
    axesHandle = axes('Parent', fig, 'Position', [0.2, 0.2, 0.6, 0.6]);

    function openImage(~, ~)
        % Allow the user to select an image file
        [filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.gif', 'Image Files (*.jpg, *.jpeg, *.png, *.bmp, *.gif)'}, 'Select an Image');
        
        % Check if the user canceled the operation
        if isequal(filename, 0)
            return;
        end

        % Load the selected input image
        input_image = imread(fullfile(pathname, filename));

        % Convert the input image to grayscale
        input_image_gray = rgb2gray(input_image);
        input_image_resized = imresize(input_image_gray, [431, 1024]);

        % Load the 100 USD bill template
        template = imread('/Users/ljh/Downloads/IPPR/FKD/USDCurrency/dollar100REAL.png'); % Provide the path to your template image

        % Perform template matching
        correlation = normxcorr2(rgb2gray(template), input_image_resized);

        % Find the location of the highest correlation
        [max_correlation, max_index] = max(correlation(:));
        [y, x] = ind2sub(size(correlation), max_index);

        % Define a threshold for considering a match
        threshold = 0.8; % Adjust this value based on your template and input images

        if max_correlation > threshold
            % Display the input image with the recognized area
            axes(axesHandle);
            imshow(input_image);
            hold on;
            rectangle('Position', [x-size(template, 2), y-size(template, 1), size(template, 2), size(template, 1)], 'EdgeColor', 'r', 'LineWidth', 2);
            hold off;
            title('100 USD bill recognized.');
        else
            % Display the input image with no recognized area
            axes(axesHandle);
            imshow(input_image);
            title('No 100 USD bill found.');
        end
    end
end
