function [ie,id] =  sincronia(ie,id,n)


% ind = 1:min([length(ie) length(id)]);
for i = 1:n    
    er(i)= abs(sum(id(1:end-i))-sum(fliplr(ie(1:end-i))));
end

emin=find(er==min(er));
emax=find(er==max(er));
ind = min([emin emax]);

id = id(1:end-ind);
ie = ie(1:end-ind);
end