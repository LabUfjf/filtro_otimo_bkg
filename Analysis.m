clear variables; clc; close all;
format long
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETROS INICIAIS:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
base.DiffType = 1;               % SELECIONA DERIVADA (1=diff) ou (0=f(t)')
base.ordem = [64 128 256];               % SCAN NA ORDEM DO FILTRO
base.type = 1;                   % TIPO DE SHAPE DO SINAL -> SHAPE FE(isTrue) | GAUSSIANO(isFalse) 
base.real = 0;                   % DADOS REAIS = 1; SIMULAÇÃO = 0
base.uniform = 1;                % FASE SINAL CRIA FASE UNIFORME = 1
base.ptCONV = 'CONV';            % CONV/MSE
base.EST = 'AMPLITUDE';          % AMPLITUDE/PHASE
base.noise = 1;                  % 0 = FE ; 1 = FE+PMT
base.pileup = 0;                 % ADICIONAR PILEUP NA VALIDAÇÃO   
base.error = 1;                  % ERROR = 1 (STD/SQRT(N)) ; ERROR = 0 (STD)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test.variable='amostras';          % SELECIONAR TIPO DE TESTE 
test=switchTest(test,base);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setup.janela=1.0240e-06;          % JANELA FIXA 
setup.N.tr = 100000;              % NÚMERO DE EVENTOS TREINAMENTO5
setup.N.v = 100000;               % NÚMERO DE EVENTOS VALIDAÇÃO
setup.Volts = 2;                  % VOLTAGEM ADC
setup.QuantCoef = 0;              % QUANTIZAR COEFICIENTES(SELECIONAR ABAIXO QUAL TIPO DE QUANTIZAÇÃO)  
setup.Quant = 1;                  % QUANTIZAÇÃO DO SINAL -> NÍVEL DE BIT (Quant = 0) | EM VOLTS (Quant = 1)     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
doPlot.NDAQ = 0;
doPlot.COEF = 0;
doPlot.save = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[INFO] = TESTOF(test,setup,base,doPlot);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PLOTOF(INFO,test,base,doPlot);   
% mao_program(INFO,['FPGATEST_PED[' num2str((10^3)*test.Pedestal) 'mV]_PHASE_UNIF[' num2str(base.uniform) ']_Bits[' num2str(test.bits) ']'],base,test,setup) % GERAR FPGATEST