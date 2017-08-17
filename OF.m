function [SR,E,out,CF,sind] = OF(test,data,base,setup,doPlot)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARÂMETROS DE ENTRADA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOISE_TRAIN = data.mod.tr.bg;         % RUÍDO UTILIZADO PARA CALCULAR MATRIZ DE COVARIÂNCIA DOS FILTROS
NOISE_TRAIN = data.mod.tr.NDAQ.bg;      % RUÍDO UTILIZADO PARA CALCULAR MATRIZ DE COVARIÂNCIA DOS FILTROS
% SHAPE_TRAIN = data.mod.tr.NDAQ.shape/max(data.mod.tr.NDAQ.shape); 

% [ShapeGAUSS] = fit([1:128]',data.tr.shape,'gauss1');

% x = 1:128;
% y= ShapeGAUSS.a1.*exp(-((x-ShapeGAUSS.b1)./(1.1*ShapeGAUSS.c1)).^2);
% plot(x,ShapeGAUSS(x),'k-'); hold on
% plot(x,y,':r')

% SHAPE_TRAIN = y'/max(y);           % SHAPE UTILIZADO PARA CALCULAR OS PARÂMETROS DOS FILTROS
SHAPE_TRAIN = data.tr.shape;           % SHAPE UTILIZADO PARA CALCULAR OS PARÂMETROS DOS FILTROS
SHAPE_ANALOG = data.tr.shape;           % SHAPE "ANALÓGICO" DO TREINAMENTO
SHAPE_VALID = data.v.sphase;            % SHAPE "ANALÓGICO" DOS DADOS DE VALIDAÇÃO

% figure
% plot(SHAPE_ANALOG,'k'); hold on
% plot(SHAPE_VALID,'v'); hold on
% pause
TRUTH.A = data.v.A;                      % AMPLITUDE QUE GEROU OS DADOS DE VALIDAÇÃO ANTES DE APLICAR A RESOLUÇÃO
TRUTH.F = data.v.F;


if base.real == 0
    NOISE_VAL = data.mod.v.NDAQ.bg;     % RUÍDO DE VALIDAÇÃO UTILIZADO NO CÁLCULO DE SNR
%   mean(mean(NOISE_VAL))
    ALL_VAL = data.mod.v.NDAQ.all;      % DADO DE VALIDAÇÃO SINAL+RUÍDO
%   ALL_VAL = data.mod.v.NDAQ.sg;      % DADO DE VALIDAÇÃO SINAL+RUÍDO
else
    NOISE_VAL = data.v.REAL.bg;           % RUÍDO DE VALIDAÇÃO UTILIZADO NO CÁLCULO DE SNR
    ALL_VAL = data.v.REAL.sg;             % DADO DE VALIDAÇÃO SINAL+RUÍDO
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SELECIONAR O ÍNDICE DO SHAPE DE ACORDO COM A ORDEM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sind = Coefciente_OF2(SHAPE_TRAIN,base.ordem,'max',test.amostras);                                      % SELECIONA QUAIS AMOSTRAS DO SHAPE DO SINAL VAO ENTRAR NO FILTRO DE ACORDO COM A ORDEM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULAR O PONTO MÁXIMO ONDE OCORRE A CONVOLUÇÃO PELO MSE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Nmax] = NmaxConv(base,ALL_VAL,SHAPE_ANALOG,SHAPE_TRAIN,SHAPE_VALID,sind,base.ptCONV);                  % INDICA QUAL DEVERIA SER O PONTO MÁXIMO EM QUE OS SINAIS SE CASAM NA CONVOLUÇÃO DE ACORDO COM A ORDEM
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