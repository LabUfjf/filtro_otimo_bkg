close all; clear variables; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARAMETROS INICIAIS

Volts=2;
amostras=128;
hertz=250;      % 125MHz
bits=10;
%% DEFINIR PLOTS
% 1 - ATIVAR / 0 - DESATIVAR

plot_spectrum=1;        %% PLOTAR POWER SPECTRUM
plot_cov=1;             %% PLOTAR COVARIÂNCIA
plot_hist=1;           %% PLOTAR HISTOGRAMA DO MEAN E MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load FE_BG_PAPER_ALL.mat


%% PLOTS

if(plot_spectrum==1)
    [ Rxx ] = MeanSpectrumPower( dado,hertz );
end


%% DOWN RESOLUTION
% Altera da resolução do ruído para X Amostras
dado_down = downreso(dado,amostras);

%% BACKGROUND INFO
[AQ.bg] = BGinfo(dado_down);
clear dado dado_down


%% PARÂMETROS DE ENTRADA:
setup.N = 50000;
setup.res = 8e-9;

%% SIMULAÇÃO DO RUÍDO
[SIM.bg.data] = BGSIM(AQ.bg.data,AQ.bg,setup.N );

if(plot_cov==1)
    Plot_covariance(AQ.bg.data,SIM.bg.data)
end

if(plot_hist==1)
    plot_hist_max(AQ.bg.data,SIM.bg.data)
end

%% ALTERAR RESOLUÇÃO DE AMPLITUDE
SIM.bg.dataNDAQ = ApplyResolution(SIM.bg.data, bits, Volts);
AQ.bg.dataNDAQ = ApplyResolution(AQ.bg.data, bits, Volts);

%% LOAD NO SINAL

load dado.mat

%% SEPARAR SINAL E RUIDO DE UMA AMOSTRA REAL NDAQ
[AQ.sg,~] = DAQinfo(dado);
clear dado




if(plot_cov==1)
    Plot_covariance(AQ.bg.dataNDAQ,SIM.bg.dataNDAQ)
end

if(plot_hist==1)
    plot_hist_max(SIM.bg.data,SIM.bg.dataNDAQ)
end