clear all;close all;
data = importdata('Coordonnees marqueur.txt');
data = string(data);
splitcells = regexp(data, '\s+', 'split');
for i=1:length(splitcells)
   X(i,1)=splitcells{i}(13);
   X(i,2)=splitcells{i}(14)    ;
end
X(1,1)='X position';
X(1,2)='Y position';

v = VideoReader('seb.mp4');
i=300;
while hasFrame(v)    
video{i-299}=readFrame(v);
i=i+1;
end


% red=video{350}(:,:,1) ;
% a = zeros(size(video{350}(:,:,1),1), size(video{350}(:,:,1), 2));
% just_red = cat(3, red, a, a);
% imshow(just_red)


