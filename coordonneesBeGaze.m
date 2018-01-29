function coordsBegaze = coordonnesBeGaze(nomFichier);

point = importdata(nomFichier);

point = string(point);

for i = 1:length(point)
   
    coordsBegaze(i,[1:4]) = strsplit(point(i,1), ';');
    
end

end