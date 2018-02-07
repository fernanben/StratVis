clear all;
close all;
scrn_size = get(0, 'ScreenSize');

% Create data
pas=1/30;
distance=5;
p=0.01;
t = -distance:pas:distance;   % Time data
x = t;
% Position data
% Draw initial figure
fig=figure('Position', [0,0,scrn_size(3),scrn_size(4)]);
whitebg(fig, 'black')
set(gcf,'Renderer','OpenGL');
h = plot(x(1),-3,'o','MarkerSize',40,'MarkerFaceColor','r','MarkerEdgeColor','none');
set(h,'EraseMode','normal');
hold on;
g = plot(x(1),3,'o','MarkerSize',40,'MarkerFaceColor',[0.1 0.1 0.1],'MarkerEdgeColor','none');
set(g,'EraseMode','normal');
xlim([-5,5]);
ylim([-10,10]);
% Animation Loop
i=1;
s=0;
vitesse=0;
while i<=length(x)
    tic
    pos(1,i)=x(i);
    set(h,'XData',x(i))
    set(g,'XData',x(i))
    drawnow;
    i = i+1;
    pause(p)   
    s=s+toc 
    pos(2,i)=s;
end
s
(distance*2)/pas
vitesse= ((distance*2)/pas)/s

