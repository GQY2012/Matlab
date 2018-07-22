function varargout = demo(varargin)
% DEMO MATLAB code for demo.fig
%      DEMO, by itself, creates a new DEMO or raises the existing
%      singleton*.
%
%      H = DEMO returns the handle to a new DEMO or the handle to
%      the existing singleton*.
%
%      DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO.M with the given input arguments.
%
%      DEMO('Property','Value',...) creates a new DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help demo

% Last Modified by GUIDE v2.5 14-Jul-2018 12:34:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @demo_OpeningFcn, ...
                   'gui_OutputFcn',  @demo_OutputFcn, ...
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


% --- Executes just before demo is made visible.
function demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to demo (see VARARGIN)

% Choose default command line output for demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = demo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
draw(hObject, eventdata, handles);


function draw(hObject, eventdata, handles)
    waveid = get(handles.listbox2,'value');
    f0 = str2double(get(handles.edit1,'String'));
    duty = str2double(get(handles.edit2,'String'));
    fs = str2double(get(handles.edit3,'String'));
    A = str2double(get(handles.edit6,'String'));
    colorid = get(handles.popupmenu3,'value');
    T = 1/f0;
    disp(waveid);
    disp(f0);
    disp(duty);
    disp(fs);
    disp(A);
    disp(colorid);
    if duty < 0 | duty > 1
        warndlg('占空比应在0~1之间','输入非法');
        return;
    end
    if f0 > fs
        warndlg('f0应小于fs','输入非法');
        return;
    end

    t=0:pi/fs:2*pi;

    hold off;
    switch (waveid)
        case 1
            duty=duty*100;
            y=square(2*pi*f0*t,duty);        
            plot(handles.axes3,t,y*A,'color',getcolor(colorid));                    
            axis([0 2*pi -1.5*A 1.5*A]);       %设置坐标轴范围
            title('方波信号');
        case 2
            y=sawtooth(2*pi*f0*t,0.5);
            plot(handles.axes3,t,y*A,'color',getcolor(colorid));
            axis([0 2*pi -1.5*A 1.5*A]);
            title('三角波信号');
        case 3
            y=sawtooth(2*pi*f0*t);
            plot(handles.axes3,t,y*A,'color',getcolor(colorid));
            axis([0 2*pi -1.5*A 1.5*A]);
            title('锯齿波信号');
        case 4
           t0 = -5*T:2*T/fs:3*T-2*T/fs;
           t = -5/4*T:2*T/fs:3/4*T-2*T/fs;
           y = zeros(1,length(t));
           index = find(t>=-5/4*T & t<-3/4*T);
           y(index) = sqrt(2)*T/4*(-3/4*T+T/2);
           index = find(t>=-3/4*T & t<-1/4*T);
           y(index) = sqrt(2)*T/4*(t(index)+T/2);
           index = find(t>=-1/4*T & t<1/4*T);
           y(index) = sqrt(2)*T/4*(-1/4*T+T/2);
           index = find(t>=1/4*T & t<=3/4*T);
           y(index) = sqrt(2)*T/4*(T/2-t(index));
        
           y = [y y y y];
           plot(handles.axes3,t0,y,'color',getcolor(colorid));

           title('梯形波信号');
    end


function color = getcolor(colorid)
switch (colorid)
    case 1
      color = 'k';
    case 2
      color = 'r';
    case 3
      color = 'g';
    case 4
      color = 'b';
    case 5
      color = 'm';
    case 6
      color = 'y';
end

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y = handles.y;

fs = 8000;
sound(y,fs);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


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


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menu1_Callback(hObject, eventdata, handles)
% hObject    handle to menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu1_1_Callback(hObject, eventdata, handles)
% hObject    handle to menu1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu1_2_Callback(hObject, eventdata, handles)
% hObject    handle to menu1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
draw(hObject, eventdata, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    N = str2double(get(handles.edit4,'String'));
    waveid = get(handles.listbox2,'value');
    f0 = str2double(get(handles.edit1,'String'));
    duty = str2double(get(handles.edit2,'String'));
    fs = str2double(get(handles.edit3,'String'));
    A = str2double(get(handles.edit6,'String'));
    colorid = get(handles.popupmenu3,'value');
    if f0 > fs
        warndlg('f0应小于fs','输入非法');
        return;
    end
     
    n = N;
    T = 1/f0;
    t = 0:pi/fs:2*pi;
    x = 0;
    w0 = 2*pi/T;
    
    hold on;
    switch(waveid)
        case 1
        for k = 1:n
            fw(k)=(2*k-1)*w0;
            a(k)=4*A/(pi*(2*k-1));
            y(k,:)=a(k)*sin(fw(k)*t);
            x = x + y(k,:);
            a = 1:100;
            if handles.radiobutton1.Value== 1 && (mod(k,floor(n/5)) == 0 || k == n)
                         figure(1);  
                         subplot(5,1,ceil(k/(n/5)));
                         plot(t,y(k,:));  
                         title([num2str(k), '次叠加的谐波 ']);
             end
        end
        plot(handles.axes3,t,x);
        axis([0 2*pi -1.5*A 1.5*A]);
        case 2
            for k = 1:n
                fw(k)=(2*k-1)*w0;
                a(k)=(-1)^(k-1)*(8*A/(pi^2*(2*k-1)^2));
                y(k,:)=a(k)*sin(fw(k)*t);
                x = x + y(k,:);
                a = 1:100;
                if handles.radiobutton1.Value== 1 && (mod(k,floor(n/5)) == 0 || k == n)
                         figure(1);  
                         subplot(5,1,ceil(k/(n/5)));
                         plot(t,y(k,:));  
                         title([num2str(k), '次叠加的谐波 ']);
                 end  
            end
        plot(handles.axes3,t+T/4,real(x));
        axis([0 2*pi -1.5*A 1.5*A]);
        case 3
            for k = 1:n
                fw(k)=k*w0;
                a(k)=-A/(pi*k);
                y(k,:)=a(k)*sin(fw(k)*t);
                x = x + y(k,:);
                a = 1:100;
                if handles.radiobutton1.Value== 1 && (mod(k,floor(n/5)) == 0 || k == n)
                         figure(1);  
                         subplot(5,1,ceil(k/(n/5)));
                         plot(t,y(k,:));  
                         title([num2str(k), '次叠加的谐波 ']);
                 end
            end
            plot(handles.axes3,t,x*2);
            case 4
                t = -5/4*T:2*T/fs:3/4*T;
                for k = 1:n
                    fw(k)=k;
                    if(mod(k,2) ~= 0)
                        a(k)=sqrt(2)*cos(k*T/4)/k^2;
                    else
                        a(k)=0;
                    end
                    y(k,:)=a(k)*sin(fw(k)*t);
                    x = x + y(k,:);
                    a = 1:100;
                    if handles.radiobutton1.Value== 1 && (mod(k,floor(n/5)) == 0 || k == n)
                         figure(1);  
                         subplot(5,1,ceil(k/(n/5)));
                         plot(t,y(k,:));  
                         title([num2str(k), '次叠加的谐波 ']);
                    end
                end
                plot(handles.axes3,t,x);
    end
hold off;
 handles.y = x;
 guidata(hObject,handles);
    


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
