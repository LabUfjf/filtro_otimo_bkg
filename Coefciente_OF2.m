function [g] = Coefciente_OF2(sinal,ordem,mod,amostras)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DOIS MÉTODOS PARA SELECIONAR AS AMOSTRAS DE ACORDO COM A ORDEM:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,nm] = max(sinal); % ENCONTRA O PICO DO SHAPE 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MÉTODO 1 - 
%       BASEADO NO SHAPE DA FRONT-END ESCOLHE AS AMOSTRAS DE ACORDO COM A
%       PORCENTAGEM DE AMOSTRAS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(mod,'pct');
    
    pctesq=0.235294117647059;
    pctdir=1-pctesq;
    
    for i=1:length(ordem)
        
        npt=ordem(i)-1;
        pd=round(npt*pctdir);
        pe=round(npt*pctesq);
        
        if nm+pd<=amostras
            g{i}=[nm-pe:nm-1 nm nm+1:nm+pd];
        else
            g{i}=[nm-pe-(nm+pd-amostras):nm-1 nm nm+1:amostras];
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MÉTODO 2 - ESTÁ SENDO UTILIZADO ATUALMENTE 
%          SELECIONA AS AMOSTRAS DA MAIOR PARA A MENOR DE ACORDO COM SER
%          VALOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(mod,'max');
    for i=1:length(ordem)
        [~,b]=sort(sinal,'descend');
        g{i}=sort(b(1:ordem(i)))';
    end
    
end

end