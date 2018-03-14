function [nbreFix,tempsTotal] = fenetreCacul(caract, masque, coords, xBegaze, yBegaze, tempsDebut, tempsFin, tailleFenetre)

nbreFix(1,[2:length(caract)+1]) = string(caract(:,1));
nbreFix(1,1) = num2str(0);
tempsTotal(1,[2:length(caract)+1]) = string(caract(:,1));
tempsTotal(1,1) = num2str(0);

nbreFixSomme = 0;
tempsTotalSomme = 0;

for i = tempsDebut:tailleFenetre:(tempsFin-tailleFenetre)
    [caract2,masque2] = codeCaract(masque, caract, i, i+tailleFenetre, coords, xBegaze, yBegaze);
    
    nbreFix((i-tempsDebut)/tailleFenetre+2,1) = strcat(num2str(i),{' - '},num2str(i+tailleFenetre));
    nbreFix((i-tempsDebut)/tailleFenetre+2,[2:length(caract(:,1))+1]) = string(caract2(:,2));
    
    tempsTotal((i-tempsDebut)/tailleFenetre+2,1) = strcat(num2str(i),{' - '},num2str(i+tailleFenetre));
    tempsTotal((i-tempsDebut)/tailleFenetre+2,[2:length(caract(:,1))+1]) = string(caract2(:,3));
end

end
    