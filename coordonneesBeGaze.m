function [coordsBegaze, X, Y] = coordonneesBeGaze(nomFichier, path);

point = importdata(fullfile(path,nomFichier), ' ');

point = string(point);

% Classe dans un tableau les informations du point txt
for i = 1:length(point)-1
        coordsBegaze(i, [1:8]) = strsplit(point(i+1, 1), ';');
        X(i,1) = str2double(coordsBegaze(i,7));
        Y(i,1) = str2double(coordsBegaze(i,8));
end

end