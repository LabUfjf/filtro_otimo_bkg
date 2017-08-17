%% main
close all; clear variables; clc;
escolha_dos_dados=1; %% Setar 0 para dado.mat e 1 para FE_PMT_DIV1.mat
if(escolha_dos_dados==0)
    load dado.mat
else
    load Ruido_FE7_Paper_Revista.mat
    dado=DIV1(85:212,:);
    clear DIV1
end
[AQ.sg,AQ.bg] = DAQinfo(dado);
clear dado

%% PARÂMETROS DE ENTRADA:
setup.N = 100000;
setup.res = 8e-9;

%% AMOSTRAGEM DO SHAPE
[AQ.sg.shape] = resample_SG(AQ.sg,setup.res);

%% SIMULAÇÃO DE SINAL E RUÍDO
[SIM.bg.data] = BGSIM(AQ.bg.data,AQ.bg,setup.N );
[SIM.sg.data,SIM.sg.A] = SGSIM(AQ.sg.shape,AQ.sg,setup.N ,SIM.bg.data);

%% APLICAR RESOLUÇÃO NO SINAL E RUÍDO SIMULADOS
[SIM.sg.data,SIM.bg.data] = ApplyADC(SIM.sg.data,SIM.bg.data);

figure
subplot(1,2,1);plot(SIM.sg.data(:,1:5),'s:'); hold on; ylabel('V'), xlabel('Samples'); axis tight
subplot(1,2,2);histogram(max(SIM.sg.data(:,:))-SIM.sg.A',100); ylabel('Occurrence Number'), xlabel('A_{est}-A_{truth}'); axis tight
[mu,std,~,~]=normfit(SIM.bg.data(:)); legend(['\mu=' num2str(mu,2) '\pm' num2str(std,2)])

% figure
% t = 0.5;
% mesh(cov(SIM.bg.data'),'FaceColor','blue','EdgeColor','blue','EdgeAlpha',t,'FaceAlpha',t);hold on
% mesh(cov(AQ.bg.data'),'FaceColor','green','EdgeColor','green','EdgeAlpha',t,'FaceAlpha',t);
% mesh((cov(SIM.bg.data')-cov(AQ.bg.data')),'FaceColor','red','EdgeColor','red','EdgeAlpha',t,'FaceAlpha',t); axis tight; grid on;
% legend('Noise SIM','Noise AQ','Error_{SIM - AQ}');
%

Plot_covariance(AQ.bg.data,SIM.bg.data)