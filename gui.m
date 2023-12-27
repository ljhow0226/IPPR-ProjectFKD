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

% Last Modified by GUIDE v2.5 27-Dec-2023 18:50:34

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
end


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

global FAKECOUNTS;
FAKECOUNTS = 0;

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global INPUTNOTE;
global FAKECOUNTS;
X = get(handles.popupmenu1,'value');

switch X
    case 2
        processLatentMark('r_f100_latent.jpg', INPUTNOTE, handles);

    case 3
        processLatentMark('r_f200_latent.jpg', INPUTNOTE, handles);

    case 4
        processLatentMark('r_f500_latent.jpg', INPUTNOTE, handles);

    case 5
        processLatentMark('r_f2000_latent.jpg', INPUTNOTE, handles);
        
    otherwise
        msgbox("Please select correct note.")
end

if isequal(X,1)
    msgbox("Please select correct note.");
end

% Make the checkbox read-only and set it to checked
set(handles.checkbox1, 'Enable', 'off', 'Value', 1);
end

function processLatentMark(latentMarkPath, INPUTNOTE, handles)
    global FAKECOUNTS;
    % Load pre-cropped latent mark
    latentMark = im2double(imread(latentMarkPath));

    % Set the correlation coefficient threshold
    correlationThreshold = 0.8;

    % Resize the detected note to a standard size
    standardSize = [940, 2060];
    resizedNote = imresize(INPUTNOTE, standardSize);

    % Crop the region of interest (left bottom) from the detected note
    cropPosition = [50, 700];
    croppedNote = imcrop(resizedNote, [cropPosition, standardSize / 2]);

    % Detect latent mark in the cropped note
    [x_detect, y_detect, w_detect, h_detect, correlation_coefficient] = correlation(croppedNote, latentMark);

    % Display the results
    axes(handles.axes3);
    imshow(croppedNote, []);
    hold on;

    % Determine whether the latent mark is found or not
    if ~isempty(x_detect) && correlation_coefficient >= correlationThreshold
        resultMessage = 'Correlation Coefficient >= 0.8 - Potentially Real';
        rectangle('Position', [x_detect, y_detect, w_detect, h_detect], 'EdgeColor', 'r', 'LineWidth', 2);
    else
        resultMessage = 'Correlation Coefficient < 0.8 - Potentially Fake';
        FAKECOUNTS = FAKECOUNTS + 1;
    end

    set(handles.edit1, 'String', resultMessage);

    title(resultMessage);
    hold off;

end


function [x, y, w, h, correlation_coefficient] = correlation(image, template)
    imageGray = im2double(rgb2gray(image));
    templateGray = im2double(rgb2gray(template));

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global INPUTNOTE
X = get(handles.popupmenu1,'value');

switch X
    case 2
        processIdentificationMark(handles, 'r_f100.jpg', [1800 430 300 200], INPUTNOTE);

    case 3
        processIdentificationMark(handles, 'r_f200.jpg', [1800 430 300 200], INPUTNOTE);

    case 4
        processIdentificationMark(handles, 'r_f500.jpg', [1800 430 300 200], INPUTNOTE);

    case 5
        processIdentificationMark(handles, 'r_f2000.jpg', [1800 430 300 200], INPUTNOTE);
        
    otherwise
        msgbox("Please select correct note.")
end

if isequal(X,1)
    msgbox("Please select correct note.");
end

% Make the checkbox read-only and set it to checked
set(handles.checkbox7, 'Enable', 'off', 'Value', 1);
end

function processIdentificationMark(handles, templateFile, cropRegion, INPUTNOTE)
    global FAKECOUNTS;
    % Read the images
    realnote = imread(templateFile);

    % Convert to grayscale
    inputnotegray = rgb2gray(INPUTNOTE);
    realnotegray = rgb2gray(realnote);

    % Crop the images for the specific feature
    cropinputnote = imcrop(inputnotegray, cropRegion);
    croprealnote = imcrop(realnotegray, cropRegion);

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
        resultMessage = 'Max Correlation > 0.9 - Potentially Real';
    else
        resultMessage = 'Max Correlation <= 0.9 - Potentially Fake';
        FAKECOUNTS = FAKECOUNTS + 1;
    end

    set(handles.edit4, 'String', resultMessage);

    axes(handles.axes3);
    imshow(inputnoteEdges, []);
    title(resultMessage);

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
        processSecurityThread(handles, 'template_100.jpg', [1176.679, 133.1638, 64.4687, 743.639], INPUTNOTE, 53745135434);
        
    case 3
        processSecurityThread(handles, 'template_200.jpg', [1121.2091, 86.6823, 55.4732, 727.1491], INPUTNOTE, 73882821251);
        
    case 4
        processSecurityThread(handles, 'template_500.jpg', [1124.75, 136.25, 88.5, 708], INPUTNOTE, 63531498076);

    case 5
        processSecurityThread(handles, 'template_2000.jpg', [1308.9737, 127.07127, 88.4813, 734.8448], INPUTNOTE, 77879205449);

    otherwise
        msgbox("Please select correct note.")
end

if isequal(X,1)
    msgbox("Please select correct note.");
end

% Make the checkbox read-only and set it to checked
set(handles.checkbox8, 'Enable', 'off', 'Value', 1);
end

function processSecurityThread(handles, templateFileName, cropRegion, INPUTNOTE, realCurrencySSDResult)
    global FAKECOUNTS;
    % Convert image to grayscale
    inputImgGray = rgb2gray(INPUTNOTE);

    % Apply morphological operations (erosion)
    se = strel('line', 5, 90);
    erodedImg = imerode(inputImgGray, se);

    % Crop the eroded image to the selected region
    x = round(cropRegion(1));
    y = round(cropRegion(2));
    width = round(cropRegion(3));
    height = round(cropRegion(4));

    croppedImage = imcrop(erodedImg, [x, y, width, height]);
    newImage = uint8(zeros(size(erodedImg)));
    [heightCropped, widthCropped, ~] = size(croppedImage);
    newImage(y:y+heightCropped-1, x:x+widthCropped-1, :) = croppedImage;

    % Save the cropped image
    imwrite(newImage, 'eroded_input.jpg');

    % Load the template image for the security thread
    template = imread(templateFileName);

    % Convert the template image to grayscale if it is in RGB format
    if size(template, 3) == 3
        templateGray = rgb2gray(template);
    else
        templateGray = template;
    end

    % Convert the eroded image to grayscale
    erodedImgGray = erodedImg;

    % Perform template matching using SSD on the eroded image
    ssdMapResult = (double(templateGray) - double(erodedImgGray)).^2;
    ssdResult = sum(ssdMapResult(:));

    % Set a threshold for matching (you can adjust this threshold)
    threshold = 1e8;

    % Determine whether it's a match or not
    if abs(ssdResult - realCurrencySSDResult) < threshold
        resultMessage = (['SSD Map (Result: ' num2str(ssdResult) ') - Potentially Real']);
    else
        resultMessage = (['SSD Map (Result: ' num2str(ssdResult) ') - Potentially Fake']);
        FAKECOUNTS = FAKECOUNTS + 1;
    end

    set(handles.edit5, 'String', resultMessage);

    axes(handles.axes3);
    imshow(ssdMapResult, []);
    title(['SSD Map (Result: ' num2str(ssdResult) ') - ' resultMessage]);

    if FAKECOUNTS >= 3
        set(handles.text9, 'Visible', 'on', 'String', 'This is a Fake Note', 'ForegroundColor', 'red');
    else
        set(handles.text9, 'Visible', 'on', 'String', 'This is a Real Note', 'ForegroundColor', 'green');
    end

end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
end

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
end

% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
end

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
end

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes during object creation, after setting all properties.
function text9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    global FAKECOUNTS;
    global INPUTNOTE;

    % Reset global variables
    FAKECOUNTS = 0;
    INPUTNOTE = [];

    % Reset UI elements
    set(handles.edit1, 'String', '');
    set(handles.edit4, 'String', '');
    set(handles.edit5, 'String', '');
    set(handles.text9, 'Visible', 'off', 'String', '');

    % Reset checkboxes
    set(handles.checkbox1, 'Enable', 'on', 'Value', 0);
    set(handles.checkbox7, 'Enable', 'on', 'Value', 0);
    set(handles.checkbox8, 'Enable', 'on', 'Value', 0);

    % Clear axes
    cla(handles.axes3);
    cla(handles.axes1);

    % Clear title
    title('');

    % Display a message
    msgbox('Variables and GUI elements have been reset.');
end
