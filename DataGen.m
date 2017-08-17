function [data] = DataGen(N,A,P,base)
% close all; clear variables; clc;
setup.doSave = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARAMETROS INICIAIS
setup.janela=1.0240e-06;                              % JANELA FIXA
setup.N = N;                                          % N�MERO DE EVENTOS
% setup.Volts = V;                                    % VOLTAGEM ADC
setup.amostras = A;                                   % N�MERO DE AMOSTRAS NO TEMPO
setup.res = setup.janela/setup.amostras;              % C�LCULO DA RESOLU��O
setup.hertz=250;                                      % 125 MHz 
% setup.bits=B;                                       % N�MERO DE BITS DO ADC;
%VE = linspace(-0.5,0,11); VD = linspace(0,0.5,11);    % CRIANDO VETOR DE FASES POSITIVAS E NEGATIVAS
VE = linspace(-0.5,0,11); VD = linspace(0,0.5,11);    % CRIANDO VETOR DE FASES POSITIVAS E NEGATIVAS
setup.phase = [VE(1:end-1) VD];                       % JUNTANDO VETOR DE FASES  
setup.bg.rmPedestal = 1;                              % REMOVER PEDESTALDO RU�DO  
setup.fitA = 1;                                       % FITAR AMPLITUDE DOS SINAIS COM UMA GAUSSIANA (isTrue)
setup.type = base.type;                               % SHAPE FE(isTrue) | GAUSSIANO(isFalse)
setup.noise = base.noise;                             % 1 = FRONT-END+PMT 0 = FRONT-END 
%% DEFINIR PLOTS
doPlot.spectrum = 0;          % PLOTAR POWER SPECTRUM
doPlot.cov      = 0;          % PLOTAR COVARI�NCIA
doPlot.hist     = 0;          % PLOTAR HISTOGRAMA DO MEAN E MAX
doPlot.shape    = 0;          % PLOTAR SHAPE DO SINAL
doPlot.fitA     = 0;          % PLOTAR FIT NO HISTOGRAMA DAS AMPLITUDES DO SINAL
% doPlot.NDAQ     = 0;          % PLOTAR SINAL COM RESOLU�AO EM AMPLITUDE DA NDAQ  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%==========================================================================
% SIMULA��O DE BACKGROUND
%==========================================================================
if setup.noise == 1
    load FE_PMT_DIV1.mat
    dado=DIV1; clear DIV1
    % REMOVER PEDESTAL DO RU�DO
    [dado] = rmPedestalBG(dado,setup.bg.rmPedestal);
    [dado] = dado(:,max(dado)<0.006);
    fc = 1.02;
    dado = dado*fc;
else
    load FE_BG_PAPER_ALL.mat
    % REMOVER PEDESTAL DO RU�DO
    [dado] = rmPedestalBG(dado,setup.bg.rmPedestal);
     [dado] = dado(:,max(dado)<0.006);
end
% PLOT ESPECTRO DE POT�NCIA
if(doPlot.spectrum==1)
    [~] = MeanSpectrumPower( dado,setup.hertz );
end
% DOWN RESOLUTION - Altera da resolu��o do ru�do para "SETUP.AMOSTRAS"
[ dado ] = fixBGSample(dado,setup.amostras);
% BACKGROUND INFO
[AQ.bg] = BGinfo(dado); clear dado
% SIMULA��O DO RU�DO
[SIM.bg.data] = BGSIM(AQ.bg.data,AQ.bg,setup.N);
% PLOS PARA COMPARA��O ENTRE RU�DO REAL E SIMULADO
if(doPlot.cov==1)
    Plot_covariance(AQ.bg.data,SIM.bg.data)
end
if(doPlot.hist==1)
    plot_hist_max(AQ.bg.data,SIM.bg.data,'Background')
end
% h = waitbar(0,'GO !!!');
i = P;
%==========================================================================
% SIMULA��O DE SINAL
%==========================================================================
% LOAD NO SINAL
load FE_PMT_DIV1.mat
dado=DIV1; clear DIV1
% ALTERANDO RESOLU��O PARA "SETUP.AMOSTRAS"
[ dado ] = fixSGSample(dado,setup.amostras);
% SEPARAR SINAL E RUIDO DE UMA AMOSTRA REAL AQUISITADA PELA NDAQ
[AQ.sg,AQ.bg] = DAQinfo(dado,setup.amostras,setup.type);  clear dado
% ALTERAR AMOSTRAGEM DO SHAPE
[AQ.sg] = doShape(AQ.sg,setup.amostras,setup.phase(i),doPlot.shape);
% SIMULA��O DO SINAL
[SIM.sg.data,SIM.sg.A] = SGSIM(AQ.sg.phase,AQ.sg,setup.N,setup.fitA,doPlot.fitA);
%==========================================================================
% PAR�METROS DE SA�DA QUE SER�O SALVAS
%==========================================================================
% CRIA��O DO SINAL + RU�DO SIMULADO
setup.nb=size(SIM.sg.data,2); % ajustar n�mero de amostras
% SALVAR STRUCT COM RESOLU��O M�XIMA EM AMPLITUDE E "SETUP.AMOSTRAS"
data.all=SIM.sg.data+SIM.bg.data(:,1:setup.nb);
data.sg=SIM.sg.data;
data.bg=SIM.bg.data(:,1:setup.nb);
% SALVAR SHAPE E TRUTH DE AMPLITUDE DAS AMOSTRAS
data.shape=AQ.sg.shape;
data.sphase=AQ.sg.phase;
data.A = SIM.sg.A;
data.F = setup.phase(i)*ones(1,length(data.A));
data.REAL.sg = AQ.sg.data;
data.REAL.bg = AQ.bg.data;
% ALTERAR RESOLU��O DE AMPLITUDE
% SIM.bg.dataNDAQ = ApplyResolution(SIM.bg.data, setup.bits, setup.Volts);
% SIM.sg.dataNDAQ = ApplyResolution(SIM.sg.data, setup.bits, setup.Volts);
% SIM.sg.dataNDAQall = ApplyResolution(data.all, setup.bits, setup.Volts);
% SALVAR EVENTOS COM RESOLU��O EM APLITUDE ALTERADAS
% data.NDAQ.all = SIM.sg.dataNDAQall;
% data.NDAQ.sg = SIM.sg.dataNDAQ;
% data.NDAQ.bg = SIM.bg.dataNDAQ(:,1:setup.nb);
% PLOTS REFERENTES AO SINAL
% if doPlot.NDAQ == 1
%     ne =randi(setup.nb,1);
%     subplot(3,1,1);stairs(data.sg(:,ne),'k'); hold on; stairs(data.NDAQ.sg(:,ne),'-r'); legend('RES_{OSC}','RES_{NDAQ}'); title('Signal'); axis tight
%     subplot(3,1,2);stairs(data.bg(:,ne),'k'); hold on; stairs(data.NDAQ.bg(:,ne),'-r'); legend('RES_{OSC}','RES_{NDAQ}'); title('Background'); axis tight
%     subplot(3,1,3);stairs(data.all(:,ne),'k'); hold on; stairs(data.NDAQ.all(:,ne),'-r'); legend('RES_{OSC}','RES_{NDAQ}'); title('Signal+Background'); axis tight
% end
if(doPlot.hist==1)
    plot_hist_max(AQ.sg.data,data.all,'Signal')
end

%% SALVAR VARI�VEL "data" COM TODAS AS INFORMA��ES QUE SER�O UTILIZADAS NO ALGORITMO DE AN�LISE
if setup.doSave == 1
    save(['DATARAW-N' num2str(setup.N) 'R' num2str(setup.res) 'A' num2str(setup.amostras) 'P' num2str(i)],'data')
end
% waitbar(i/21)
% close(h)

end