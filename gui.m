function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 26-Dec-2023 22:26:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global INPUTNOTE
X = get(handles.popupmenu1,'value');

switch X
    case 2
        % Read the images
        global INPUTNOTE
        realnote = imread('r_f100.jpg');

        % Convert to grayscale
        inputnotegray = rgb2gray(INPUTNOTE);
        realnotegray = rgb2gray(realnote);

        % Crop the images for the specific feature (Identification Mark in this case)
        cropinputnote = imcrop(inputnotegray,[1800 430 300 200]); 
        croprealnote = imcrop(realnotegray,[1800 430 300 200]); 

        % Edge detection
        inputnoteEdges = edge(cropinputnote, 'Roberts');
        realnoteEdges = edge(croprealnote, 'Roberts');

        % Cross-correlation for pattern matching
        correlationOutput = normxcorr2(inputnoteEdges, realnoteEdges);
        threshold = 0.9;
        maxValue = max(correlationOutput(:));
        isIdMarkPresent = maxValue > threshold;

        % Print result
        if isIdMarkPresent
            resultMessage = 'The currency note is Real.';
        else
            resultMessage = 'The currency note is Fake.';
        end

    case 3
         % Read the images
        global INPUTNOTE
        realnote = imread('r_f200.jpg');

        % Convert to grayscale
        inputnotegray = rgb2gray(INPUTNOTE);
        realnotegray = rgb2gray(realnote);

        % Crop the images for the specific feature (Identification Mark in this case)
        cropinputnote = imcrop(inputnotegray,[1800 430 300 200]); 
        croprealnote = imcrop(realnotegray,[1800 430 300 200]); 

        % Edge detection
        inputnoteEdges = edge(cropinputnote, 'Roberts');
        realnoteEdges = edge(croprealnote, 'Roberts');

        % Cross-correlation for pattern matching
        correlationOutput = normxcorr2(inputnoteEdges, realnoteEdges);
        threshold = 0.9;
        maxValue = max(correlationOutput(:));
        isIdMarkPresent = maxValue > threshold;

        % Print result
        if isIdMarkPresent
            resultMessage = 'The currency note is Real.';
        else
            resultMessage = 'The currency note is Fake.';
        end
        
    case 4
         % Read the images
        global INPUTNOTE
        realnote = imread('r_f500.jpg');

        % Convert to grayscale
        inputnotegray = rgb2gray(INPUTNOTE);
        realnotegray = rgb2gray(realnote);

        % Crop the images for the specific feature (Identification Mark in this case)
        cropinputnote = imcrop(inputnotegray,[1800 430 300 200]); 
        croprealnote = imcrop(realnotegray,[1800 430 300 200]); 

        % Edge detection
        inputnoteEdges = edge(cropinputnote, 'Roberts');
        realnoteEdges = edge(croprealnote, 'Roberts');

        % Cross-correlation for pattern matching
        correlationOutput = normxcorr2(inputnoteEdges, realnoteEdges);
        threshold = 0.9;
        maxValue = max(correlationOutput(:));
        isIdMarkPresent = maxValue > threshold;

        % Print result
        if isIdMarkPresent
            resultMessage = 'The currency note is Real.';
        else
            resultMessage = 'The currency note is Fake.';
        end

        
    case 5
         % Read the images
        global INPUTNOTE
        realnote = imread('r_f2000.jpg');

        % Convert to grayscale
        inputnotegray = rgb2gray(INPUTNOTE);
        realnotegray = rgb2gray(realnote);

        % Crop the images for the specific feature (Identification Mark in this case)
        cropinputnote = imcrop(inputnotegray,[2100 400 300 200]); 
        croprealnote = imcrop(realnotegray,[2100 400 300 200]); 

        % Edge detection
        inputnoteEdges = edge(cropinputnote, 'Roberts');
        realnoteEdges = edge(croprealnote, 'Roberts');

        % Cross-correlation for pattern matching
        correlationOutput = normxcorr2(inputnoteEdges, realnoteEdges);
        threshold = 0.9;
        maxValue = max(correlationOutput(:));
        isIdMarkPresent = maxValue > threshold;

        % Print result
        if isIdMarkPresent
            resultMessage = 'The currency note is Real.';
        else
            resultMessage = 'The currency note is Fake.';
        end

        
    otherwise
        msgbox("Please select correct note.")
end

axes(handles.axes3);

if isequal(X,1)
    imshow(INPUTNOTE);
else
    imshow(inputnoteEdges);
        imshow(inputnoteEdges, []);
    title(['Output Result: ' resultMessage]);
end
        
  


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global INPUTNOTE
X = get(handles.popupmenu1,'value');

switch X
    case 2
        % Convert image to grayscale
        inputImgGray = rgb2gray(INPUTNOTE);

        % Apply morphological operations (erosion)
        se = strel('line', 5, 90);  % Create a vertical line structuring element
        erodedImg = imerode(inputImgGray, se);  % Erosion using the same structuring element

        % Set the region of interest (replace with your provided values)
        x = round(1176.679);
        y = round(133.1638);
        width = round(64.4687);
        height = round(743.639);

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
        templateFileName = 'template_100.jpg';
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
        realCurrencySSDResult = 53745135434;
        threshold = 1e8; % Adjust based on the observations

        % Determine whether it's a match or not
        if abs(ssdResult - realCurrencySSDResult) < threshold
            resultMessage = 'It is real currency!';
        else
            resultMessage = 'It is fake currency!';
        end
        
    case 3
        % Convert image to grayscale
        inputImgGray = rgb2gray(INPUTNOTE);

        % Apply morphological operations (erosion)
        se = strel('line', 5, 90);  % Create a vertical line structuring element
        erodedImg = imerode(inputImgGray, se);  % Erosion using the same structuring element

        % Set the region of interest (replace with your provided values)
        x = round(1121.2091);
        y = round(86.6823);
        width = round(55.4732);
        height = round(727.1491);

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
        templateFileName = 'template_200.jpg';
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
        realCurrencySSDResult = 73882821251;
        threshold = 1e8; % Adjust based on the observations

        % Determine whether it's a match or not
        if abs(ssdResult - realCurrencySSDResult) < threshold
            resultMessage = 'It is real currency!';
        else
            resultMessage = 'It is fake currency!';
        end
        
    case 4
        % Convert image to grayscale
        inputImgGray = rgb2gray(INPUTNOTE);

        % Apply morphological operations (erosion)
        se = strel('line', 5, 90);  % Create a vertical line structuring element
        erodedImg = imerode(inputImgGray, se);  % Erosion using the same structuring element

        % Set the region of interest (replace with your provided values)
        x = round(1124.75);
        y = round(136.25);
        width = round(88.5);
        height = round(708);
        
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
        templateFileName = 'template_500.jpg';
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
        realCurrencySSDResult = 63531498076;
        threshold = 1e8; % Adjust based on the observations

        % Determine whether it's a match or not
        if abs(ssdResult - realCurrencySSDResult) < threshold
            resultMessage = 'It is real currency!';
        else
            resultMessage = 'It is fake currency!';
        end
        
    case 5
        % Convert image to grayscale
        inputImgGray = rgb2gray(INPUTNOTE);

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
        threshold = 1e8; % Adjust based on the observations

        % Determine whether it's a match or not
        if abs(ssdResult - realCurrencySSDResult) < threshold
            resultMessage = 'It is real currency!';
        else
            resultMessage = 'It is fake currency!';
        end
 
    otherwise
        msgbox("Please select correct note.")
end

axes(handles.axes3);

if isequal(X,1)
    imshow(INPUTNOTE);
else
    imshow(ssdMapResult, []);
    title(['SSD Map (Result: ' num2str(ssdResult) ') - ' resultMessage]);
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global INPUTNOTE
[file,path] = uigetfile({'*.*'});
note_input = fullfile(path, file);
INPUTNOTE = imread(note_input);
axes(handles.axes1);
imshow(INPUTNOTE);
