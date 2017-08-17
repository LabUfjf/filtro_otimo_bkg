function [TR,VAL,A] = GenerateData(setup,base,change)
%% GERAR DADOS DE TREINAMENTO
[TR.BG] = BGGen(setup,base,change.nf);
[TR.SG,TR.shape,~] = SGGen(setup,base,change.phase,TR.BG);
%% GERAR DADOS DE VALIDAÇÃO
[VAL.BG] = BGGen(setup,base,change.nf);
[VAL.SG,VAL.shape,A] = SGGen(setup,base,change.phase,TR.BG);
%% SOMAR SINAL + RUÍDO DE VALIDAÇÃO
VAL.ALL=VAL.SG+VAL.BG;
%% APLICAR RESOLUÇÃO
[VAL.ALL] = ApplyResolution(VAL.ALL, change.bits, 2);
[TR.BG] = ApplyResolution(TR.BG, change.bits, 2);
end