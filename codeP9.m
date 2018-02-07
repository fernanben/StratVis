clear all;
close all;
clc;

% méthode inpolygon


masque = parserXML('paticipant-9.xml');
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
%     
%         plot(xMasque,yMasque,'LineWidth',2) % polygon
%         axis equal
% 
%         hold on
%         plot(xCoords(masque{i,5}),yCoords(masque{i,5}),'r+') % points inside
%         plot(xCoords(~masque{i,5}),yCoords(~masque{i,5}),'bo') % points outside
%         hold off
    else
        masque{i,5}=false;
        masque{i,6}=num2str(0);
        masque{i,7}=num2str(0);
end


end

a = masque(:,[1 5 6 7]);
a=string(a);

mannequin = 0;
TempsMannequin = 0;

pa = 0;
TempsPA = 0;

etCO2 = 0;
TempsEt = 0;

sat = 0;
TempsSat = 0;

fi = 0;
TempsFi = 0;

fc = 0;
TempsFC = 0;

in = find(strcmp(a(:,2),'true'));

Mannequin = find(strcmp(a(:,1),'Tete et corps'));
Mannequin = a(Mannequin,:);

PA = find(strcmp(a(:,1),'PA'));
PA = a(PA,:);

Sat = find(strcmp(a(:,1),'Saturation'));
Sat = a(Sat,:);

FiO2 = find(strcmp(a(:,1),'FiO2'));
FiO2 = a(FiO2,:);

FC = find(strcmp(a(:,1),'FC'));
FC = a(FC,:);

EtCO2 = find(strcmp(a(:,1),'etCO2'));
EtCO2 = a(EtCO2,:);

if strcmp(Mannequin(1,2),'true')
    mannequin = mannequin+1;
end

if strcmp(PA(1,2),'true')
    pa = pa+1;
end

if strcmp(Sat(1,2),'true')
    sat = sat+1;
end

if strcmp(FiO2(1,2),'true')
    fi = fi+1;
end

if strcmp(EtCO2(1,2),'true')
    etCO2 = etCO2+1;
end

if strcmp(FC(1,2),'true')
    fc = fc+1;
end

for m1 = 2:length(Mannequin)
    if strcmp(Mannequin(m1,2),'true') & strcmp(Mannequin(m1-1,2),'false')
        mannequin = mannequin+1;
        TempsMannequin = TempsMannequin+str2double(Mannequin(m1,4));
    end
end

for m2 = 2:length(PA)
    if strcmp(PA(m2,2),'true') & strcmp(PA(m2-1,2),'false')
        pa = pa+1;
        TempsPA = TempsPA+str2double(PA(m2,4));
    end
end

for m3 = 2:length(EtCO2)
    if strcmp(EtCO2(m3,2),'true') & strcmp(EtCO2(m3-1,2),'false')
        etCO2 = etCO2+1;
        TempsEt = TempsEt+str2double(EtCO2(m3,4));
    end
end

for m4 = 2:length(Sat)
    if strcmp(Sat(m4,2),'true') & strcmp(Sat(m4-1,2),'false')
        sat = sat+1;
        TempsSat = TempsSat+str2double(Sat(m4,4));
    end
end

for m5 = 2:length(FiO2)
    if strcmp(FiO2(m5,2),'true') & strcmp(FiO2(m5-1,2),'false')
        fi = fi+1;
        TempsFi = TempsFi+str2double(FiO2(m5,4));
    end
end

for m6 = 2:length(FC)
    if strcmp(FC(m6,2),'true') & strcmp(FC(m6-1,2),'false')
        fc = fc+1;
        TempsFC = TempsFC+str2double(FC(m6,4));
    end
end
        

% mannequin = 0;
% TempsMannequin = 0;
% 
% PA = 0;
% TempsPA = 0;
% 
% etCO2 = 0;
% TempsEt = 0;
% 
% Sat = 0;
% TempsSat = 0;
% 
% Fi = 0;
% TempsFi = 0;
% 
% FC = 0;
% TempsFC = 0;
% 
% if strcmp(masque{in(1),1},'Tete et corps')
%     mannequin = mannequin+1;
% end
% if strcmp(masque{in(1),1},'PA')
%     PA = PA+1;
% end
% if strcmp(masque{in(1),1},'Saturation')
%     Sat = Sat+1;
% end
% if strcmp(masque{in(1),1},'FiO2')
%     Fi = Fi+1;
% end
% if strcmp(masque{in(1),1},'etCO2')
%     etCO2 = etCO2+1;
% end
% if strcmp(masque{in(1),1},'FC')
%     FC = FC+1;
% end
% 
% for p = 2:length(in)
%             if strcmp(masque{in(p),1},'Tete et corps')
% %                 TempsMannequin = TempsMannequin+str2double(coords2(index,8))
%                 if strcmp(string(masque{in(p)-1,5}),'false') & strcmp(masque{in(p-1),1},'Tete et corps')==false
%                     mannequin = mannequin+1;
%                 end
%             elseif strcmp(masque{in(p),1},'PA')
% %                 TempsPA = TempsPA+str2double(coords2(index,8))
%                 if strcmp(string(masque{in(p)-1,5}),'false') & strcmp(masque{in(p-1),1},'PA')==false
%                     PA = PA+1;
%                 end
%             elseif strcmp(masque{in(p),1},'Saturation')
% %                 TempsSat = TempsSat+str2double(coords2(index,8))
%                 if strcmp(string(masque{in(p)-1,5}),'false') & strcmp(masque{in(p-1),1},'Saturation')==false
%                     Sat = Sat+1;
%                 end                
%             elseif strcmp(masque{in(p),1},'FC')
% %                 TempsFC = TempsFC+str2double(coords2(index,8))
%                 if strcmp(string(masque{in(p)-1,5}),'false') & strcmp(masque{in(p-1),1},'FC')==false
%                 FC = FC+1;
%                 end                
%             elseif strcmp(masque{in(p),1},'FiO2') 
% %                 TempsFi = TempsFi+str2double(coords2(index,8))
%                 if strcmp(string(masque{in(p)-1,5}),'false') & strcmp(masque{in(p-1),1},'FiO2')==false
%                 Fi = Fi+1;
%                 end               
%             elseif strcmp(masque{in(p),1},'etCO2')
% %                 TempsEt = TempsEt+str2double(coords2(index,8))
%                 if strcmp(masque{in(p-1),1},'etCO2')==false
%                     etCO2 = etCO2+1;
%                 elseif strcmp(masque{in(p-1),1},'etCO2')==true & 
%                 end                
%             end
% end
% 
% 
% 
