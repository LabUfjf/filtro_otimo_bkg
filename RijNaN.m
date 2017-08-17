function [ matrix ] = RijNaN( x )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Função para calculo do Espetro de Potência Médio do Ruído              %
% Inputs:                                                                 %
%        x - Matriz de correlação ruído MxM |                             %
%                                                                         %
% Outputs:                                                                %
%        mean_cov_x_shift - Média do Espectro de Potência                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% corr_x=corr(x');
corr_x=x;
[a,~]=size(corr_x);

for j=0:(a-1);
    k1=1;
    k2=1;
    aux1=0;
    aux2=0;
    for i=1:(a-j)
        if(~isnan(corr_x(i+(j), i)))
            teste2(k1) = corr_x(i+(j), i);
            k1=k1+1;
            aux1=1;
        end
        if(~isnan(corr_x(i, i+(j))))
            teste4(k2) = corr_x(i, i+(j));
            k2=k2+1;
            aux2=1;
        end
    end
    if(aux1==1)
        teste3{j+1}=teste2;
    end
    if(aux2==1)
        teste5{j+1}=teste4;
    end
    clear teste2 teste4;
end

[i0] = inDiagNaN(corr_x);
if ~isempty(i0)
    for l=1:length(i0)
        teste3{i0(l)}=0;
        teste5{i0(l)}=0;
    end
end
for k=1:a
    
    corr_media1(k)=mean(teste3{k});
    corr_media2(k)=mean(teste5{k});
end

Rxx=[corr_media2(a-(0:(a-1))) corr_media1(2:end)];

matrix=zeros(size(corr_media1));

teste=fliplr(corr_media2);

for i=1:length(corr_media1)
    matrix(i,i:end)=corr_media1(1:(end-(i-1)));
    matrix(length(corr_media1)-(i-1),1:(end-(i-1)))=teste(i:end);
end
