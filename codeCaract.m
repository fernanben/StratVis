% function [caract,masque] = codeCaract(masque, caract, coords2, xBegaze2, yBegaze2);

close all;
clear all;
clc;

[masque, caract] = parserXML('paticipant-9.xml');
[coords2, xBegaze2, yBegaze2] = coordonneesBeGaze('participant 9_4.txt');

for j = 1:length(coords2)
    tempsCoords(j,2) = str2double(coords2(j,5));
    tempsCoords(j,2) = tempsCoords(j,2)/1000;
    tempsCoords(j,1) = str2double(coords2(j,4));
    tempsCoords(j,1) = tempsCoords(j,1)/1000;
end

for i = 1:length(masque)
    m=1;
    index=0;
    tempsM(i,1) = str2double(masque(i,3));
    while tempsM(i,1)>tempsCoords(m,2)
        m=m+1;
    end
    if tempsM(i,1)>tempsCoords(m,1)
        index=m;
        masque{i,6} = num2str(index);
        masque{i,7} = coords2(index,6);
        xCoords = xBegaze2(index);
        yCoords = yBegaze2(index);
        xMasque = str2double(masque{i,4}(1,:));
        yMasque = str2double(masque{i,4}(2,:));
    
        masque{i,5} = inpolygon(xCoords, yCoords, xMasque, yMasque);

    else
        masque{i,5}=false;
        masque{i,6}=num2str(0);
        masque{i,7}=num2str(0);
    end
end

a = masque(:,[1 5 6 7]);
a=string(a);

for r = 1:length(caract)
    indexMasque = find(strcmp(a(:,1),caract(r,1)));
    Masque = a(indexMasque,:);
    indexMasqueIn = find(strcmp(Masque(:,2),'true'));
    if isempty(indexMasqueIn)==0
        minMasque = min(indexMasqueIn);
        minMasqueIn(r) = indexMasque(minMasque);
    else
        minMasqueIn(r)="";
    end
    compteur = 0;
    compteur2 = 0;
    if strcmp(Masque(1,2),'true')
        compteur = compteur+1;
    end
    for m0 = 2:length(Masque)
        if strcmp(Masque(m0,2),'true') & strcmp(Masque(m0-1,2),'false')
            compteur = compteur+1;
            compteur2 = compteur2+str2double(Masque(m0,4));
        end
    end
    caract(r,2) = num2str(compteur);
    caract(r,3) = num2str(compteur2);
end

[ordre,indexOrdre] = sort(minMasqueIn);

for t=1:length(indexOrdre)
    caract(indexOrdre(t),4)=num2str(t);    
end

for p = 1:length(minMasqueIn)
    if isnan(minMasqueIn(p))==1
        caract(p,4)="NULL";
    end
end

