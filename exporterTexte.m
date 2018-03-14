function texte = exporterTexte(filename, path, caract, coords, tempsDebut, tempsFin)

texte(1,1) = strcat('Participant :',{' '},coords(1,1));
texte(2,1) = strcat({' '});
texte(3,1) = strcat('Temps de debut (ms) :', {' '}, num2str(tempsDebut),{', '}, 'Temps de fin (ms) :',{' '}, num2str(tempsFin))
texte(4,1) = strcat({' '});
texte(5,1) = strcat('Region interet :' ,{' '}, 'Nom', {', '}, 'Nombre de visites', {', '}, 'Temps total de fixation', {', '},'Ordre de decouverte')
texte(6,1) = strcat({' '});

for i=1:length(caract(:,1))
    texteCaract(i,[1:4]) = caract(i,:);
    texte(i+6,1) = char(strcat('Region interet :',{' '},char(texteCaract(i,1)),{', '},char(texteCaract(i,2)),{', '}, char(texteCaract(i,3)),{', '}, char(texteCaract(i,4))));
end

f=fopen(fullfile(path,filename),'wt');

for j = 1:length(texte(:,1))
    fprintf(f,'%s\n',texte(j,1));
end

end

