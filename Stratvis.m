function Stratvis
clear all;
close all;
clc;

%scrn_size = get(0, 'ScreenSize');
%[0,0,scrn_size(3),scrn_size(4)]
f = figure('Name', 'StratVis', ...
    'Visible', 'on', ...
    'Position', [0,0,1366,768], ...
    'NumberTitle', 'Off', ...
    'MenuBar', 'none', ...
    'resize', 'on'...
    );

uicontrol( ...
    'Parent', f, ...
    'Style', 'text', ...
    'HorizontalAlignment', 'left', ...
    'FontSize', 10, ...
    'String', 'Participant :', ...
    'Position', [100, 430, 105, 15]...
    );
participant_edit = uicontrol( ...
    'Parent', f, ...
    'Style', 'text', ...
    'HorizontalAlignment', 'left', ...
    'FontSize', 10, ...
    'String', '', ...
    'Position', [190, 430, 105, 15]...
    );
%---------------------------------------------------------------------------------------------------------------------
%----------------------------------------------Panel de chargement----------------------------------------------------
%---------------------------------------------------------------------------------------------------------------------

chargement = uipanel( ...
    'Parent', f, ...
    'Title', 'Chargement des donn�es', ...
    'Units', 'Pixels', ...
    'FontSize', 10, ...
    'Position', [50, 520, 400, 200 ] ...
    );

load_button1 = uicontrol('Parent', chargement, ...
    'Style', 'pushbutton', ...
    'FontSize', 10, ...
    'String', 'Coordonn�es Marqueur', ...
    'Tag','Load_button1',...
    'Position', [20, 130, 200, 30], ...
    'callback', {@load1_callback}...
    );

load_button2 = uicontrol('Parent', chargement, ...
    'Style', 'pushbutton', ...
    'FontSize', 10, ...
    'String', 'Coordonn�es Masques', ...
    'Tag','Load_button2',...
    'Position', [20, 90, 200, 30], ...
    'callback', {@load2_callback}...
    );
% set(load_button2, 'Enable', 'off');

load_button3 = uicontrol('Parent', chargement, ...
    'Style', 'pushbutton', ...
    'FontSize', 10, ...
    'String', 'Vid�o', ...
    'Tag','Load_button3',...
    'Position', [20, 50, 200, 30],...
    'callback', {@load3_callback}...
    );
% set(load_button3, 'Enable', 'off');

validation_button = uicontrol('Parent', chargement, ...
    'Style', 'pushbutton', ...
    'FontSize', 10, ...
    'String', 'Valider', ...
    'Position', [250, 90, 120, 30], ...
    'callback', {@validation_callback}...
    );


%---------------------------------------------------------------------------------------------------------------------
%----------------------------------------------PanelVid�o-------------------------------------------------------------
%---------------------------------------------------------------------------------------------------------------------
v = uipanel( ...
    'Parent', f, ...
    'Title', 'Chargement des donn�es', ...
    'Units', 'Pixels', ...
    'FontSize', 10, ...
    'Position', [500, 400, 800, 320 ] ...
    );

handles.movie_scrn = axes( ...
    'Parent', v, ...
    'tag', 'movie_scrn', ...
    'Units', 'Pixels', ...
    'YTick', [], ...
    'XTick', [], ...
    'NextPlot', 'add', ...
    'Position', [20, 10, 380, 340] ...
    );
set(handles.movie_scrn, 'Visible', 'off');

movie_slider = uicontrol( ...
    'Parent', v, ...
    'Style', 'slider', ...
    'String', 'test', ...
    'Position', [450, 20, 220, 20], ...
    'Callback', {@movieslider_callback}...
    );
set(movie_slider, 'min',1);
set(movie_slider, 'max',100);
set(movie_slider, 'value',2);
addlistener(movie_slider, 'ContinuousValueChange', @movieslider_callback);

handles.play_button = uicontrol( ...
    'Parent', v, ...
    'Style', 'pushbutton', ...
    'FontSize', 10, ...
    'String', 'Play', ...
    'Tag','play_button',...
    'Position', [450, 180, 60, 25],...
    'callback', {@play_Callback} ...
    );
handles.stop_button = uicontrol( ...
    'Parent', v, ...
    'Style', 'pushbutton', ...
    'FontSize', 10, ...
    'String', 'Pause', ...
    'Position', [520, 180, 60, 25],...
    'callback', {@stop_Callback} ...
    );
uicontrol( ...
    'Parent', v, ...
    'Style', 'text', ...
    'HorizontalAlignment', 'left', ...
    'FontSize', 10, ...
    'String', 'Debut (sec) :', ...
    'Position', [450, 110, 105, 15], ...
    'callback', {@stop_Callback} ...
    );

starttimemap_edit = uicontrol( ...
    'Parent', v, ...
    'Style', 'edit', ...
    'FontSize', 10, ...
    'Value', 0, ...
    'Position', [580, 110, 60, 20],...
    'Callback', {@time_edit_callback}...
    );
uicontrol( ...
    'Parent', v, ...
    'Style', 'text', ...
    'HorizontalAlignment', 'left', ...
    'FontSize', 10, ...
    'String', 'Temps actuel (sec) :', ...
    'Position', [450, 140, 105, 15], ...
    'callback', {@stop_Callback} ...
    );

Currenttime_edit = uicontrol( ...
    'Parent', v, ...
    'Style', 'edit', ...
    'FontSize', 10, ...
    'Value', 0, ...
    'Position', [580, 140, 60, 20]...
    );
% endtimemap_text =
uicontrol( ...
    'Parent', v, ...
    'Style', 'text', ...
    'HorizontalAlignment', 'left', ...
    'FontSize', 10, ...
    'String', 'Fin (sec) :', ...
    'Position', [450, 80, 105, 15] ...
    );

endtimemap_edit = uicontrol( ...
    'Parent', v, ...
    'Style', 'edit', ...
    'FontSize', 10, ...
    'Position', [580, 80, 60, 20],...
    'Callback', {@endtime_callback}...
    );

handles.valider = uicontrol( ...
    'Parent', v, ...
    'Style', 'pushbutton', ...
    'FontSize', 10, ...
    'String', 'Valider intervalle', ...
    'Position', [630, 180, 120, 25],...
    'callback', {@Valider_Callback} ...
    );


%---------------------------------------------------------------------------------------------------------------------
%----------------------------------------------Tableau--------------------------------------------------------------
%---------------------------------------------------------------------------------------------------------------------
tab = uitable(...
    'Parent',f,...
    'Position',[50 20 1250 350]...
    );
tab.ColumnName = {'ROI','Nombre de fixation','Temps total','Ordre de decouverte'};
tab.ColumnEditable = true;
set(tab,'ColumnWidth',{304});

%les figures se deplacent avec le screen
h_fig = findobj(f, '-not', 'Units', 'normalized');
lgt_h_fig = length(h_fig);
for l = 1:lgt_h_fig
    if isprop(h_fig(l), 'Units')
        set(h_fig(l), 'Units', 'normalized')
    end
end
movegui(f, 'center')
%---------------------------------------------------------------------------------------------------------------------
%----------------------------------------------Variables--------------------------------------------------------------
%---------------------------------------------------------------------------------------------------------------------
handles.filename3='';
handles.mem=1;
handles.endtime=2000;
handles.depart=1;

handles.debut=0;
handles.fin=0;

handles.coords=[];
handles.xBegaze=[];
handles.yBegaze=[];

handles.caract=[];
handles.masque=[];
handles.caract1=[];
handles.masque1=[];
handles.masqueS=[];
%---------------------------------------------------------------------------------------------------------------------
%----------------------------------------------Callbacks--------------------------------------------------------------
%---------------------------------------------------------------------------------------------------------------------

    function load1_callback (hObject,~)
        set(load_button2, 'Enable', 'on');
        [FileName,PathName,FilterIndex] = uigetfile('*.txt', 'Selectionner le fichier texte avec les coordonn�es du marqueur');
        disp(hObject.String)
        handles = guihandles(hObject);
        handles.Load_button1.String = FileName;
        handles.marqueur = importdata(FileName);
        handles.filename1=FileName;
        [handles.coords, handles.xBegaze, handles.yBegaze] = coordonneesBeGaze(handles.filename1);
        handles.debut=min(str2double(handles.coords(:,4)));
        handles.fin=max(str2double(handles.coords(:,5)));
        guidata(load_button1, handles)
    end
    function load2_callback (hObject,~)
        set(load_button3, 'Enable', 'on');
        [FileName,PathName,~] = uigetfile('*.xml', 'Selectionner le fichier texte avec les coordonn�es des masques');
        disp(hObject.String)
        handles=guidata(load_button1)
        handles.Load_button2.String = FileName;
        handles.masque = importdata(FileName);
        handles.filename2=FileName;
        [handles.masqueS, handles.caract] = parserXML(handles.filename2);
        guidata(load_button1, handles);
    end
    function load3_callback (source,~)
        handles = guihandles(source);
        currAxes = handles.movie_scrn; 
        %recuperation nom/chemin ... du fichier recherch�
        [FileName,~,~] = uigetfile('*.avi', 'Selectionner la vid�o');
       %initialisation handles  
        handles=guidata(load_button1)
        handles.filename3=FileName ;       
        set(load_button3, 'String' , handles.filename3); 
        handles.mem=1;
        
        obj = VideoReader(FileName);
        this_frame = read(obj, handles.mem);
        %rotations image
        this_frame=imrotate(this_frame,180);
        this_frame = flip(this_frame ,2);
        %affichage sur l'axe
        image(this_frame, 'Parent', currAxes);
        
        handles.endtime =ceil(obj.FrameRate*obj.Duration);
        set(movie_slider, 'min',1,'max',handles.endtime);
        set(starttimemap_edit,'String',0);
        set(endtimemap_edit,'String',handles.endtime/30);
         set(participant_edit,'String',handles.filename3);
        guidata(load_button1,handles)
    end
    function play_Callback(source,~)
        %initialisation
        handles = guihandles(source);
        currAxes = handles.movie_scrn;
        handles=guidata(load_button1)
        obj = VideoReader(handles.filename3);
        handles.play_button.Value =1;
        handles.depart=handles.mem;
        set(starttimemap_edit,'String',num2str(round(handles.depart/30,2)));
        %boucle d'affichage des frames
        for k= handles.depart:handles.endtime
            %condition d'arret
            if handles.play_button.Value ==1
                %                 set(endtimemap_edit,'String','');
                this_frame = read(obj,k);
                this_frame=imrotate(this_frame,180);
                this_frame = flip(this_frame ,2);
                cla;
                image(this_frame, 'Parent', currAxes);
                handles.mem = k;
                set(movie_slider, 'Value',k);
                set(Currenttime_edit,'String',num2str(round(k*(1/30),0)));
                pause(1/60)
            end
            guidata(load_button1,handles)
        end
    end
    function stop_Callback(~,~)
        handles=guidata(load_button1);
        handles.play_button.Value = 0;
        set(endtimemap_edit, 'String', handles.mem/30);
        guidata(load_button1,handles)
    end
    function validation_callback(source,~)
        handles=guidata(load_button1)
        [handles.caract1, handles.masque1] = codeCaract(handles.masqueS, handles.caract,handles.debut,handles.fin, handles.coords, handles.xBegaze, handles.yBegaze);
        set(tab, 'Data', handles.caract1)
        guidata(load_button1, handles);
    end
    function Valider_Callback(~,~)
        handles=guidata(load_button1)
        handles.debut=str2double(get(starttimemap_edit,'String'))*1000
        handles.fin=str2double(get(endtimemap_edit,'String'))*1000
        guidata(load_button1,handles)
    end
    function time_edit_callback(source, ~)
        handles=guihandles(source);
        currAxes = handles.movie_scrn;
        handles=guidata(load_button1);
        handles.mem=str2double(get(source,'String'))*30
        
        obj = VideoReader(handles.filename3);
        this_frame = read(obj,handles.mem);
        this_frame=imrotate(this_frame,180);
        this_frame = flip(this_frame ,2);
        image(this_frame, 'Parent', currAxes);
        currAxes.Visible = 'off' ;
        guidata(load_button1,handles)
    end
    function movieslider_callback(source, ~)
        set(endtimemap_edit,'String','');
        set(starttimemap_edit,'String','');        
        val = get(source, 'Value');
        handles=guidata(load_button1)
        currAxes = handles.movie_scrn;
        obj = VideoReader(handles.filename3);
        handles.endtime =ceil(obj.FrameRate*obj.Duration);
        set(movie_slider, 'max',handles.endtime);
        i = round(val)
        set(currAxes, 'NextPlot', 'add', 'YTick', [], 'XTick', []);
        this_frame=read(obj,i);
        this_frame=imrotate(this_frame,180);
        this_frame = flip(this_frame ,2);
        image(this_frame, 'Parent', currAxes);
        axis off;
        
        set(Currenttime_edit,'String',i/30);
        handles.mem=i;
        guidata(load_button1,handles)
        
    end
    function endtime_callback(source,~)
        handles=guidata(load_button1);
        handles.endtime=str2double(get(source,'String'))*30
        guidata(load_button1,handles)
    end
end