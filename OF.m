function [SR,E,out,CF,sind] = OF(test,data,base,setup,doPlot)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PAR�METROS DE ENTRADA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOISE_TRAIN = data.mod.tr.bg;         % RU�DO UTILIZADO PARA CALCULAR MATRIZ DE COVARI�NCIA DOS FILTROS
NOISE_TRAIN = data.mod.tr.NDAQ.bg;      % RU�DO UTILIZADO PARA CALCULAR MATRIZ DE COVARI�NCIA DOS FILTROS
% SHAPE_TRAIN = data.mod.tr.NDAQ.shape/max(data.mod.tr.NDAQ.shape); 

% [ShapeGAUSS] = fit([1:128]',data.tr.shape,'gauss1');

% x = 1:128;
% y= ShapeGAUSS.a1.*exp(-((x-ShapeGAUSS.b1)./(1.1*ShapeGAUSS.c1)).^2);
% plot(x,ShapeGAUSS(x),'k-'); hold on
% plot(x,y,':r')

% SHAPE_TRAIN = y'/max(y);           % SHAPE UTILIZADO PARA CALCULAR OS PAR�METROS DOS FILTROS
SHAPE_TRAIN = data.tr.shape;           % SHAPE UTILIZADO PARA CALCULAR OS PAR�METROS DOS FILTROS
SHAPE_ANALOG = data.tr.shape;           % SHAPE "ANAL�GICO" DO TREINAMENTO
SHAPE_VALID = data.v.sphase;            % SHAPE "ANAL�GICO" DOS DADOS DE VALIDA��O

% figure
% plot(SHAPE_ANALOG,'k'); hold on
% plot(SHAPE_VALID,'v'); hold on
% pause
TRUTH.A = data.v.A;                      % AMPLITUDE QUE GEROU OS DADOS DE VALIDA��O ANTES DE APLICAR A RESOLU��O
TRUTH.F = data.v.F;


if base.real == 0
    NOISE_VAL = data.mod.v.NDAQ.bg;     % RU�DO DE VALIDA��O UTILIZADO NO C�LCULO DE SNR
%   mean(mean(NOISE_VAL))
    ALL_VAL = data.mod.v.NDAQ.all;      % DADO DE VALIDA��O SINAL+RU�DO
%   ALL_VAL = data.mod.v.NDAQ.sg;      % DADO DE VALIDA��O SINAL+RU�DO
else
    NOISE_VAL = data.v.REAL.bg;           % RU�DO DE VALIDA��O UTILIZADO NO C�LCULO DE SNR
    ALL_VAL = data.v.REAL.sg;             % DADO DE VALIDA��O SINAL+RU�DO
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SELECIONAR O �NDICE DO SHAPE DE ACORDO COM A ORDEM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sind = Coefciente_OF2(SHAPE_TRAIN,base.ordem,'max',test.amostras);                                      % SELECIONA QUAIS AMOSTRAS DO SHAPE DO SINAL VAO ENTRAR NO FILTRO DE ACORDO COM A ORDEM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULAR O PONTO M�XIMO ONDE OCORRE A CONVOLU��O PELO MSE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Nmax] = NmaxConv(base,ALL_VAL,SHAPE_ANALOG,SHAPE_TRAIN,SHAPE_VALID,sind,base.ptCONV);                  % INDICA QUAL DEVERIA SER O PONTO M�XIMO EM QUE OS SINAIS SE CASAM NA CONVOLU��O DE ACORDO COM A ORDEM
% save Nmax Nmax
% pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULAR OS COEFICIENTES DOS FILTROS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CF = GetCoefOF(NOISE_TRAIN', base.ordem, SHAPE_TRAIN', sind, base.DiffType, base.type,'Mean',doPlot,setup,test);   % CALCULA OS COEFICIENTES DOS FILTROS DE ACORDO COM A ORDEM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% APLICAR OS FILTROS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[SR,E,out] = Analise_SNR_Ordem(ALL_VAL,NOISE_VAL,CF,base,TRUTH,Nmax);                                  % APLICA OS FILTROS
end