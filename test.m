function imageViewerGUI
    fig = figure('Position', [100, 100, 600, 400], 'Name', 'Image Viewer', 'NumberTitle', 'off', 'Menubar', 'none');

    % Create a uicontrol (button) to open an image
    uicontrol('Style', 'pushbutton', 'String', 'Open Image', 'Position', [20, 20, 100, 30], 'Callback', @openImage);

    % Create an axes to display the image
    axesHandle = axes('Parent', fig, 'Position', [0.15, 0.15, 0.7, 0.7]);

    % Callback function to open an image
    function openImage(~, ~)
        % Allow the user to select an image file
        [filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.gif', 'Image Files (*.jpg, *.jpeg, *.png, *.bmp, *.gif)'}, 'Select an Image');
        
        % Check if the user canceled the operation
        if isequal(filename, 0)
            return;
        end
        
        % Read and display the selected image
        fullImagePath = fullfile(pathname, filename);
        image = imread(fullImagePath);
        imshow(image, 'Parent', axesHandle);
        title(axesHandle, 'Selected Image');
    end
end





