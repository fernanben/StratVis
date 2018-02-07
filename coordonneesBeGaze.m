function [coordsBegaze, X, Y] = coordonnesBeGaze(nomFichier);

point = importdata(nomFichier, ' ');

point = string(point);

for i = 1:length(point)-1
        coordsBegaze(i, [1:8]) = strsplit(point(i+1, 1), ';');
        X(i,1) = str2double(coordsBegaze(i,7));
        Y(i,1) = str2double(coordsBegaze(i,8));
end

% for j=1:length(coordsBegaze)
%     
%     coordsD = coordsBegaze(j,4);
%     coordsF = coordsBegaze(j,5);
% 
%     coordsD = strsplit(coordsD, ':');
%     coordsF = strsplit(coordsF, ':');
% 
%     minuteD = str2double(coordsD(1,2));
%     secondeD = str2double(coordsD(1,3));
%     millisecD = coordsD(1,4);
%     
%     minuteF = str2double(coordsF(1,2));
%     secondeF = str2double(coordsF(1,3));
%     millisecF = coordsF(1,4);
% 
%     secD = minuteD*60+secondeD;
%     secD = num2str(secD);
%     coordsBegaze(j,4) = strcat(secD,',',millisecD);
%     
%     secF = minuteF*60+secondeF;
%     secF = num2str(secF);
%     coordsBegaze(j,5) = strcat(secF,',',millisecF);
%     
%     coordsBegaze(j,8) = num2str(str2double(coordsBegaze(j,5))-str2double(coordsBegaze(j,4)));
%     
% end

end