function [CV,A]=MSE_MATRIX_Conv(DADO,FILTRO,Nmax,base)

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

% save CV CV

if base.real==0
    if base.uniform == 1
        for i=1:length(Nmax)
            A(i) = CV(Nmax(i),i);
        end
    else
        A = CV(Nmax,:);
    end
else
    for i=1:length(DADO)
        A(i) = CV(Nmax(1),i);
    end
end

end