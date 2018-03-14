function [caract,masque] = codeCaract(masque, caract, tempsDebut, tempsFin, coords2, xBegaze2, yBegaze2);


% S�lectionner les coordonn�es sup�rieures au temps de d�but
temps = find(str2double(coords2(:,4))>=tempsDebut);
coords2 = coords2(temps, :);
xBegaze2 = xBegaze2(temps, :);
yBegaze2 = yBegaze2(temps, :);

% S�lectionner les coordonn�es inf�rieures au temps de fin
temps2 = find(str2double(coords2(:,5))<=tempsFin);
coords2 = coords2(temps2, :);
xBegaze2 = xBegaze2(temps2, :);
yBegaze2 = yBegaze2(temps2, :);

% Stockage des temps en seconde dans une variable
for j = 1:length(coords2(:,1))
    tempsCoords(j,2) = str2double(coords2(j,5));
    tempsCoords(j,2) = tempsCoords(j,2)/1000;
    tempsCoords(j,1) = str2double(coords2(j,4));
    tempsCoords(j,1) = tempsCoords(j,1)/1000;
end

for i = 1:length(masque(:,1))
    m=1;
    index=0;
    tempsM(i,1) = str2double(masque(i,3));
    if isempty(coords2(:,1))==0
        %comparaison des temps de Sensarea et de BeGaze
        while tempsM(i,1)>tempsCoords(m,2) & m<length(tempsCoords(:,1))
            m=m+1;
        end
        % Si le temps de Sensarea est compris dans un intervalle de temps
        % de fixation de BeGaze, alors...
        if tempsM(i,1)>tempsCoords(m,1) & tempsM(i,1)<=tempsCoords(m,2)
            index=m;
            masque{i,6} = num2str(index);
            masque{i,7} = coords2(index,6);
            xCoords = xBegaze2(index);
            yCoords = yBegaze2(index);
            xMasque = str2double(masque{i,4}(1,:));
            yMasque = str2double(masque{i,4}(2,:));
    
            % M�thode permettant de comparer un point avec un masque et
            % renvoie 1 si dedans ou 0 si dehors
            masque{i,5} = inpolygon(xCoords, yCoords, xMasque, yMasque);

        else
            masque{i,5}=false;
            masque{i,6}=num2str(0);
            masque{i,7}=num2str(0);
        end
    else    
        masque{i,5}=false;
        masque{i,6}=num2str(0);
        masque{i,7}=num2str(0);
    end
end

% b permet de s�lectionner les index ou les masques sont compris que dans
% des fixations et pas des saccades
b = find(~strcmp(masque(:,6),'0'));
masque = masque(b,:);

a = masque(:,[1 5 6 7]);
a=string(a);

for r = 1:length(caract(:,1))
    % Permet de classer les masques dans une variable Masque selon leur nom
    indexMasque = find(strcmp(a(:,1),caract{r,1}));
    Masque = a(indexMasque,:);
    % Permet de classer les masques dans une variable MasqueIn selon leur nom et
    % selon le fait si le point de regard est � l'int�rieur du masque ou
    % non
    indexMasqueIn = find(strcmp(Masque(:,2),'true'));
    MasqueIn = Masque(indexMasqueIn,:);
    if isempty(indexMasqueIn)==0
        minMasque = min(indexMasqueIn);
        minMasqueIn(r) = indexMasque(minMasque);
    else
        minMasqueIn(r) = "NULL";
    end
    compteur = 0;
    compteur2 = 0;
    if isempty(Masque)==0
        % Si la longueur de la variable Masque est �gale � 1
        if length(Masque(:,1))==1
            % Compteur �gal � 1 si la premi�re valeur est true
            if strcmp(Masque(1,2),'true')
                compteur = compteur+1;
            end
        else
            % Compteur �gal � 1 si la premi�re valeur est true
            if strcmp(Masque(1,2),'true')
                compteur = compteur+1;
            end
            for m0 = 2:length(Masque(:,1))
                % Compte le nombre de visite dans la zone 
                if strcmp(Masque(m0,2),'true') & strcmp(Masque(m0-1,2),'false')
                    compteur = compteur+1;
                end
            end
        end
        if isempty(MasqueIn)==0
            compteur2 = str2double(MasqueIn(1,4));
            if length(MasqueIn(:,1))==1
                compteur2 = str2double(MasqueIn(1,4));
            else
                % calcule le temps total dans une ROI
                for t=2:length(MasqueIn(:,1))
                    if str2double(MasqueIn(t,4))~=str2double(MasqueIn(t-1,4))
                        compteur2 = compteur2+str2double(MasqueIn(t,4));
                    end
                end
            end
        end
        caract{r,2} = num2str(compteur);
        caract{r,2} = char(caract{r,2});
        caract{r,3} = num2str(compteur2);
        caract{r,3} = char(caract{r,3});
    else
        caract{r,2} = num2str(0);
        caract{r,3} = num2str(0);
    end
end



[ordre,indexOrdre] = sort(minMasqueIn);

% classe dans un tableau les diff�rentes informations calcul�es
for t=1:length(indexOrdre)
    caract{indexOrdre(t),4}=num2str(t);    
    caract{indexOrdre(t),4} = char(caract{indexOrdre(t),4});
end

% �crit NULL dans l'ordre de d�couverte si la zone n'a jamais �t� ouverte
for p = 1:length(caract(:,1))
    if strcmp(caract(p,2),'0')
        caract{p,4} = "NULL";
        caract{p,4}=char(caract{p,4});
    end
end

end

