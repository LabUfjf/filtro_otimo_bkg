function [CV]=convDavid(DADO,FILTRO)

td = size(DADO,1);
nd = size(DADO,2);
tf = size(FILTRO,1);
nc=(td-tf+1);

DADOW =[DADO; 0*ones(tf,nd)];
FILTROW = [FILTRO; 0*ones(td,1)];

for s = 1:nc
    MF(:,s) = circshift(FILTROW,s-1);
end

CV = MF'*DADOW;


end