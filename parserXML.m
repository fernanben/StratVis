function [masqueCoords, nomMasque,fps] = parserXML(nomFichier, path)

% Lis le document XML
xDoc=xmlread(fullfile(path,nomFichier)); 

import javax.xml.xpath.*;

factory = XPathFactory.newInstance; 

xpath = factory.newXPath; 

expression = xpath.compile('sensarea/masks/mask');

listeMask = expression.evaluate(xDoc, XPathConstants.NODESET);

% définit le nombre de masques
longueurMask = listeMask.getLength;

expression = xpath.compile('sensarea/layers/layer');

listeLayer = expression.evaluate(xDoc, XPathConstants.NODESET);

longueurLayer = listeLayer.getLength;

 b=1;
 c=1;
 j=1;
 m=1;
 x=0;
 h = waitbar(0,'Veuillez patienter');
 
 fps = 0;
 
 layer = 'sensarea/video/width';
 
 expression = xpath.compile(layer);
    
 largeur = cellstr(expression.evaluate(xDoc, XPathConstants.STRING));
 
 % définit le nombre d'image par seconde selon la taille de l'image
 if strcmp(largeur,'1280')
     fps = 24;
 else 
     fps = 30;
 end

 % Récupère les masques et leurs coordonnées
for i=1:longueurMask
    layer = strcat('sensarea/masks/mask[', int2str(i), ']/layer');
    
    expression = xpath.compile(layer);
    
    masque(i,3) = cellstr(expression.evaluate(xDoc, XPathConstants.STRING));    
        
    frame = strcat('sensarea/masks/mask[',int2str(i),']/frame');
        
    expression = xpath.compile(frame);
        
    masque(i,2) = cellstr(expression.evaluate(xDoc, XPathConstants.STRING));   
        
    coords = strcat('sensarea/masks/mask[',int2str(i),']/polygon/@points');
        
    expression = xpath.compile(coords);
        
    masque(i,1) = cellstr(expression.evaluate(xDoc, XPathConstants.STRING));
        
end

% Récupère le nom des masques
for n=1:longueurLayer
    for k=1:longueurMask

        if strcmp(masque(k,3),int2str(n))
    
            name = strcat('sensarea/layers/layer[', int2str(n), ']/name');
        
            expression = xpath.compile(name);
        
            name = expression.evaluate(xDoc, XPathConstants.STRING);
    
            masque(k,3) = cellstr(name);
           
        end
    end
    
    name = strcat('sensarea/layers/layer[', int2str(n), ']/name');
        
    expression = xpath.compile(name);
        
    name = expression.evaluate(xDoc, XPathConstants.STRING);
    
    nomMasque{n,1} = string(name);
    nomMasque{n,1} = char(nomMasque{n,1});
    
end

coords = masque(:,1);
coords = string(coords);

masqueCoords(:,2) = masque(:,2);

masqueCoords(:,1) = masque(:,3);

% Calcule le temps selon les frames
for s = 1 : longueurMask
    frameTemps = str2double(masqueCoords(s,2));
    frameTemps = frameTemps/fps;
    frameTemps = num2str(frameTemps);
    masqueCoords{s,3} = frameTemps;
end 

for p = 1 : longueurMask   
    masqueCoords{p,4} = strsplit(coords(p));
end   

for y = 1 : longueurMask
    for z = 1 : length(masqueCoords{y,4})
        masqueCoords{y,4}([1:2],z) = strsplit(masqueCoords{y,4}(1,z),',');
    end
end

 close(h)

end


