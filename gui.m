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
        realnote = imread('100-front-real.jpg');

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
            msgbox('The currency note is Real.');
        else
            msgbox('The currency note is Fake.');
        end

    case 3
         % Read the images
        global INPUTNOTE
        realnote = imread('200-front-real.jpg');

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
            msgbox('The currency note is Real.');
        else
            msgbox('The currency note is Fake.');
        end
        
    case 4
         % Read the images
        global INPUTNOTE
        realnote = imread('500-front-real.jpg');

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
            msgbox('The currency note is Real.');
        else
            msgbox('The currency note is Fake.');
        end

        
    case 5
         % Read the images
        global INPUTNOTE
        realnote = imread('2000-front-real.jpg');

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
            msgbox('The currency note is Real.');
        else
            msgbox('The currency note is Fake.');
        end

        
    otherwise
        msgbox("Please select correct note.")
end

axes(handles.axes3);

if isequal(X,1)
    imshow(INPUTNOTE);
else
    imshow(inputnoteEdges);
end
        
  


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
