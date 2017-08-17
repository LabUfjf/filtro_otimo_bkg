% close all; 
clear variables; clc
%% APLICAÇÃO DE FILTROS 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARAMETROS
setup.janela=1.0240e-06; %% FIXO
setup.N = 40000;
setup.amostras=128;
setup.res = setup.janela/setup.amostras;
setup.Pedestal= 0E-3;
setup.phase = 11;                   % 11 = fase zero
setup.Volts=2;
setup.bits=10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIAVEIS BASE
base.DiffType=0;          % seleciona o tipo de derivada (1=diff) ou (0=f(t)')
base.ordem = [3:2:81];   %-> ordem do filtro
base.type=1;              %-> 1=front-end; 0=gaussiano
base.bin=150;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load(['DATARAW-N' num2str(setup.N) 'R' num2str(setup.res) 'A' num2str(setup.amostras) 'P' num2str(setup.phase) 'V' num2str(setup.Volts) 'B' num2str(setup.bits)]);

[data] = DataGen(setup.N,setup.amostras,setup.Volts,setup.bits,setup.phase);

SNR_base = SNR(data.sg, data.bg, 1);
SNR_NDAQ = SNR(data.NDAQ.sg, data.NDAQ.bg, 1);

%% CALCULA OS INDICES DO SHAPE PARA OS FILTROS
sind = Coefciente_OF2(data.shape,base.ordem,'max',setup.amostras);

%% CALCULA COEFICIENTE DOS FILTROS
[CF] = GetCoefOF(data.NDAQ.bg', base.ordem, data.shape', sind, base.DiffType, base.type);

%% SNR DOS FILTOS
[SNRF,out] = Analise_SNR_Ordem(data.NDAQ.all,data.NDAQ.bg,data.A,CF,base.ordem,setup.Pedestal);


figure
plot(base.ordem,SNR_base*ones(length(base.ordem),1),'-om');hold on
plot(base.ordem,SNR_NDAQ*ones(length(base.ordem),1),'-sm');hold on
plot(base.ordem,SNRF(:,1),'-ok');hold on
plot(base.ordem,SNRF(:,2),'-or')
plot(base.ordem,SNRF(:,3),'-ob')
plot(base.ordem,SNRF(:,4),'-oc')
plot(base.ordem,SNRF(:,5),'-oy')
plot(base.ordem,SNRF(:,6),'-og')
legend('Base','NDAQ','sem restrição','restrição de fase (1ª derivadas)','restrição de fase (1ª e 2ª derivadas)','restrição de pedestal','restrição de pedestal e fase(1ª derivadas)','restrição de pedestal e fase(1ª e 2ª derivadas)')
xlabel('Order')
ylabel('SNR')
grid on

% figure
% histogram(data.A-out{1},base.bin);hold on
% histogram(data.A-out{2},base.bin);
% histogram(data.A-out{3},base.bin);
% histogram(data.A-out{4},base.bin);
% histogram(data.A-out{5},base.bin);
% histogram(data.A-out{6},base.bin);
% % histogram(data.A-max(data.all),100);
% 
% legend('sem restrição','restrição de fase (1ª derivadas)','restrição de fase (1ª e 2ª derivadas)','restrição de pedestal','restrição de pedestal e fase(1ª derivadas)','restrição de pedestal e fase(1ª e 2ª derivadas)')
% xlabel('A_{truth}-A_{est}')
% ylabel('Counts')



