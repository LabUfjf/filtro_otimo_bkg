%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           PROGRAMA DE PÓS GRADUAÇÃO EM ENGENHARIA ELÉTRICA - PPEE
%               UNIVERSIDADE FEDERAL DE JUIZ DE FORA - UFJF 
% 
% Projeto Filtro Ótimo
% Descrição: Aplicação de técnicas de filtro ótimo em sinal gaussiano e nos
% sinais do NDAQ.
% 
% Grupo:
% Rafael Antunes Nóbrega                       <rafael.nobrega@ufjf.edu.br>
% Tiago Araujo Alvarenga                  <tiago.araujo@engenharia.ufjf.br>
% Tony Igor Dornelas                     <tony.dornelas@engenharia.ufjf.br>
% 
%                                                   Juiz de fora 30-09-2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear variables; close all force; clc;
scrsz = get(0,'ScreenSize'); scrsz = scrsz*0.7; tic
FontTit = 20;       % tamanho fonte titulo
FontLeg = 16;       % tamanho fonte legenda
FontAxi = 20;       % tamanho fonte eixo
FontX = 18;         % tamanho fonte titulo eixo x
FontY = 18;         % tamanho fonte titulo eixo y
FontZ = 18;         % tamanho fonte titulo eixo z
Espessura = 1.5;    % Espessura plot

% try
%    PASTA = 'C:\Users\Projeto Atlas\Google Drive\NEUTRINOS-UFJF\Filtro_Otimo';     % Try block
% catch ME
%    PASTA = sprintf('%s\\Figuras',cd);     % Catch block
% end 
% mkdir(PASTA); 

format longG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Parametros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Save       = 0;   % Ativa metodo de salvar plots
Plots      = 0;   % Ativa metodo de geração de plots
DiffType   = 0;   % seleciona o tipo de derivada (1=diff) ou (0=f(t)')
SignalType = 1;   % Seleciona método da formação do sinal de interesse 
SAVETXT    = 0;   % ativa salvar dados em txt para plote com root  

ordem = [10:2:45];   %-> ordem do filtro
type = 1;            %-> 1=front-end; 0=gaussiano
AT = [1 0];        % Tipo de análise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NL = 2000;                  %-> nº de realizações;
NC = 128;                   %-> nº de amostras;
NS = 30;                    %-> nº de amostra da forma de onda do sinal;
N_mu    = 0* 1.39e-5;       %-> média do sinal de ruído
N_sigma = 1.2e-3;           %-> Desvio Padrão do sinal de ruído
S_mu    = 34.75e-3;         %-> média do sinal de interesse
S_sigma = 9.72e-3;          %-> Desvio Padrão do sinal de interesse
Pedestal = 10e-3;

for fn = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Gerar Shape (nº pontos, fase, FE/Gaussiano)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Shape = ShapeFunction(NS,0,type);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Sinal Total si
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
no = round(NC*(1/5));
s = [zeros(1,no) Shape zeros(1,NC-no-length(Shape))];

% no = 49
% load('FuncShapeTony');
% s1 = FuncShape(1:NC);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Sinal Normalizado g(t) utilizado no Filtro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[aux,nm] = max(Shape);
nm = no+nm;
nf = no+NS;

[g] = Coefciente_OF(ordem, NS, NC, no, nm, nf, s, SignalType, type);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Gerar Ruído Correlacionado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% yy  = [0.561678993442167,0.478265910924892,0.450907163012277,0.421399822331654,0.393485040764629,0.372489921176865,0.351431144863632,0.332514923675153,0.314985221085631,0.299610196447821,0.286908754287778,0.274303391472470,0.263622087657250,0.253915601735750,0.246238714717913,0.237645389536893,0.230658742996928,0.221586019442732,0.215157022934201,0.204443676823884,0.199935649183078,0.188001938511311,0.184348879170978,0.173988616332880,0.167341456482998,0.161175691707102,0.151091639157358,0.144107322101796,0.139031851087189,0.129437560738927,0.123261717377640,0.118863032880244,0.110579006173514,0.100600588608403,0.0929951549577746,0.0843548597655170,0.0766847710387856,0.0685002941330558,0.0627232680022313,0.0601903578553874,0.0521975642341050,0.0463253620280168,0.0403035023369483,0.0361599676876749,0.0309414948576870,0.0256955911608524,0.0212657200973363,0.0176834960977334,0.0107220935617901,0.00929003116659915,0.00630562891846603,0.00227048660265995,-0.000877074631639607,-0.00406257318265280,-0.00752623118240162,-0.00976629186689532,-0.00865199015455313,-0.0116520332262436,-0.0122028849665443,-0.0149807237546267,-0.0140794985504427,-0.0145497691481000,-0.0154131045760677,-0.0195651014338309,-0.0197842631256223,-0.0181894220682417,-0.0239312682311865,-0.0226017031478180,-0.0201060647507276,-0.0216471375058487,-0.0177335087007192,-0.0186123423307528,-0.0180492251421913,-0.0180923443730925,-0.0173673993322842,-0.0129787934202811,-0.0139852732851215,-0.0118432886462169,-0.00823177970037876,-0.00890847113659539,-0.00718726743783059,-0.00864542956594859,-0.00689303930106344,-0.00326878950199334,-0.00596961268471744,-0.00221548224747510,0.00156113484491194,0.00560160169639709,0.00690188183353053,0.00780139557981762,0.00915278175137096,0.00752642134439004,0.00900440785981333,0.0117954629060992,0.0123598161475862,0.0149736877610509,0.0168189246168403,0.0165183735939542,0.0178402371167866,0.0189034803352062,0.0232424539682006,0.0254648295877602,0.0280008298669181,0.0282770401552711,0.0326232399438300,0.0330738763161705,0.0370583404620309,0.0372240190945455,0.0362130228824773,0.0352533704073147,0.0354872696532178,0.0338098507523141,0.0363344413121595,0.0388473844502070,0.0405396359862166,0.0406162712675980,0.0398824361538254,0.0415562895174439,0.0407315094326526,0.0393367663277125,0.0414083434903605,0.0415006671357963,0.0391707073712205,0.0392625080711879,0.0348820791246920,0.0336411770684799,0.0346794615259036,0.0336915699954428];
fit = [0.538721565610702,0.497056546631643,0.459894831580825,0.426874658909443,0.397643850451900,0.371859620556843,0.349188629434061,0.329307294704232,0.311902362650533,0.296671727444507,0.283325473270137,0.271587101472462,0.261194893299339,0.251903349151289,0.243484638098504,0.235729987248954,0.228450939691712,0.221480412353712,0.214673491161503,0.207907910159512,0.201084173281142,0.194125291710058,0.186976125484361,0.179602334374633,0.171988959257073,0.164138670367451,0.156069732187986,0.147813745627406,0.139413236095482,0.130919160717833,0.122388409149761,0.113881370291228,0.105459631925707,0.0971838723130375,0.0891119925991935,0.0812975271927748,0.0737883566740514,0.0666257350254604,0.0598436306424000,0.0534683692661689,0.0475185571417272,0.0420052546858288,0.0369323649702148,0.0322971974639129,0.0280911657001169,0.0243005776915422,0.0209074797819411,0.0178905178959819,0.0152257845021312,0.0128876246866565,0.0108493802124123,0.00908405599109857,0.00756489876028841,0.00626588270518461,0.00516210113370920,0.00423006699243481,0.00344792794382871,0.00279560390401272,0.00225485639667329,0.00180929987621479,0.00144436539726094,0.00114722675700229,0.000906698615744129,0.000713115211828592,0.000558197225401571,0.000434913195899544,0.000337340731947826,0.000260531626441669,0.000200383946307486,0.000153523234584568,0.000117194158668953,8.91632692022997e-05,6.76329973412993e-05,5.11666060234740e-05,3.86235111402251e-05,2.91041865020736e-05,2.19037463062717e-05,1.64732447068622e-05,1.23877291362045e-05,9.32011877900630e-06,7.02004038186352e-06,5.29683064242103e-06,4.00599992382470e-06,3.03853993731204e-06,2.31254388914330e-06,1.76668833640274e-06,1.35519971604795e-06,1.04399418220639e-06,8.07736673427891e-07,6.27614195385086e-07,4.89659641631981e-07,3.83496787261106e-07,3.01405184187718e-07,2.37626398949710e-07,1.87851178578886e-07,1.48841464956000e-07,1.18152384422950e-07,9.39280132393897e-08,7.47513700615369e-08,5.95341406316023e-08,4.74354483930110e-08,3.78018321342479e-08,3.01227049634702e-08,2.39971266490965e-08,1.91088626239395e-08,1.52075345872875e-08,1.20942708885705e-08,9.61070087482445e-09,7.63045170073333e-09,6.05253239516097e-09,4.79615290922876e-09,3.79664336259860e-09,3.00222369679660e-09,2.37143572238277e-09,1.87109473918560e-09,1.47465122892243e-09,1.16087790955605e-09,9.12816067823369e-10,7.16929227812500e-10,5.62423060559650e-10,4.40698842229398e-10,3.44914336725475e-10,2.69631154430944e-10,2.10531745503720e-10,1.64192463105551e-10,1.27901758570142e-10,9.95146831072197e-11,7.73365740134232e-11];

C = toeplitz(fit);      
U = chol(C);            

%ku = -0.001;  ks = 0.00089; 
ku=0; ks=0;
R = normrnd(N_mu+ku, N_sigma+ks, NL, NC);
NoiseBase = 1.36*R * U;     % fator = 1.36 para ajustar as médias do ruído
Noise = fn* NoiseBase;

clear R C U yy fit ku ks NoiseBase;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Gerar Realização
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ku = +0.000;  ks = 0.00;
Amp = normrnd(S_mu+ku, S_sigma+ks, NL, 1);

for i=1:NL
    S(i,:) = Noise(i,:) + Amp(i) * s;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Aplicar resolução do ADC 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Bits  = 10;
Volts = 2;
ADC = str2double(sprintf('%1.4e',  Volts/(2^Bits-1)));
S     = ApplyResolution(S, Bits, Volts);
Noise = ApplyResolution(Noise, Bits, Volts);

[muhat,sigmahat] = normfit(max(Noise'));
Noise_mu         = mean(muhat);
Noise_sigma      = mean(sigmahat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Calcular Matriz de Autocorrelação Rij
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[NL, NC] = size(Noise);
Rij = zeros(NC,NC);

for i=1:NC
    for j=1:NC
        Rij(i,j) = sum((Noise(:,i)-mean(Noise(:,i))).*(Noise(:,j)-mean(Noise(:,j))))/sqrt(sum((Noise(:,i)-mean(Noise(:,i))).^2)*sum((Noise(:,j)-mean(Noise(:,j))).^2));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Calcular Pesos do Filtro Ótimo                               (MÉTODO 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X = linsolve(A,B) solves the matrix equation AX = B;
% 
% | R11  R12 ... R1n  g1  g1'  1 | |a1| = |0 |
% | R21  R22 ... R2n  g2  g2'  1 | |a2| = |0 |
% |  :    :   :   :   :   :    : | |: | = |: |
% | Rn1  Rn2 ... Rnn  gn  gn'  1 | |an| = |0 |
% | g1   g2  ... gn   0   0    0 | |L | = |1 |    (*) Estimar Amplitude
% | g1'  g2' ... gn'  0   0    0 | |p | = |0 |    (*) restrição de defasagem 
% | 1    1   ... 1    0   0    0 | |k | = |0 |    (*) restrição de pedestal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Para testar a geração do filtro basta fazer a matriz de autocorrelação
% % Rij igual a identidade. Isto acarretara nos pesos do filtro sendo iguais 
% % aos shape do sinal;
% % OBS: Na hora de aplicar a convolução entre o sinal e os pesos do filtro
% é necessário alterar a ordem dos pesos com flipud ou fliplr;
% Rij = eye(size(Rij));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[a0,a1,a2,a3,a4,a5] = GetCoefOF(Noise, ordem, s, g, DiffType, type);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reconstrução do Sinal Com o Filtro Ótimo a0 (Estimar Amplitude)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
best = 1;
SNR_base = SNR(S, Noise_sigma)

 if AT(1) == 1; [SNR_OF0(fn,:),SNR_OF1(fn,:),SNR_OF2(fn,:),SNR_OF3(fn,:),out] = Analise_SNR_Ordem(S,Noise,a0,a1,a2,a3,ordem,NL,NC,Pedestal); end        % roda análise de performance Ordem vs SNR
%  if AT(2) == 1; Analise_SNR_Ordem_Aquisition; end   % análise NDAQ


end


figure('Position',[50 100 scrsz(3)  scrsz(4)])
plot(ordem, ones(1,length(ordem))*SNR_base,'x-','Color',[153 153 153]/255,'LineWidth',Espessura);
hold on
plot(ordem,SNR_OF0,'ks--','LineWidth',Espessura);
plot(ordem,SNR_OF1,'kd--','LineWidth',Espessura);
plot(ordem,SNR_OF2,'kp--','LineWidth',Espessura);
plot(ordem,SNR_OF3,'ko--','LineWidth',Espessura);
% plot(ordem(best),SNR_OF0(best),'ks--', 'MarkerEdgeColor','k','MarkerFaceColor','c','LineWidth',Espessura);
% xlabel('Order','FontWeight','bold','FontSize',FontX)
% ylabel('SNR (dB)','FontWeight','bold','FontSize',FontY)
% set(gca,'FontSize',FontAxi);
legend_handle = legend('SNR Signal (Pedestal)','SNR OF (No Immunity)','SNR OF (Phase Immunity)','SNR OF (Pedestal Immunity)','SNR OF (Pedestal and Phase Immunity)','Location','Best');
set(legend_handle, 'FontSize', FontLeg);

figure('Position',[50 100 scrsz(3)  scrsz(4)])
bin =  calcnbins((-Amp+max(out{1}')')/ADC);
[Hy,xout] = hist((-Amp+max(out{1}')')/ADC, bin);
stairs(xout,Hy,'k--','DisplayName','Amplitude','LineWidth',Espessura);
set(gca,'FontSize',FontAxi);
hold on
bin  = calcnbins((-Amp+max(out{2}')')/ADC);
[Hy,xout] = hist((-Amp+max(out{2}')')/ADC, bin);
stairs(xout,Hy,'Color',[153 153 153]/255, 'DisplayName','Amplitude','LineWidth',Espessura);
xlabel('A_{out} - A_{truth}','FontWeight','bold','FontSize',FontX)
ylabel('Entries','FontWeight','bold','FontSize',FontY)
legend_handle = legend('OF (No Immunity)','OF (Pedestal Immunity)','Location','Best');
set(legend_handle, 'FontSize', FontLeg);

figure('Position',[50 100 scrsz(3)  scrsz(4)])
plot(Amp/ADC, max(out{1}')'/ADC, '.k')
hold on
plot(Amp/ADC, max(out{2}')'/ADC, '.','Color',[153 153 153]/255)
set(gca,'FontSize',FontAxi);
xlabel('A_{truth}','FontWeight','bold','FontSize',FontX)
ylabel('A_{out}','FontWeight','bold','FontSize',FontY)
legend_handle = legend('OF (No Immunity)','OF (Pedestal Immunity)','Location','Best');
set(legend_handle, 'FontSize', FontLeg);
grid minor






% transparency=0.5;
% mesh([1:10],[ordem],SNR_OF0','FaceColor','red','EdgeColor','red','EdgeAlpha',transparency,'FaceAlpha',transparency);hold on
% mesh([1:10],[ordem],SNR_OF1','FaceColor','black','EdgeColor','black','EdgeAlpha',transparency,'FaceAlpha',transparency)
% mesh([1:10],[ordem],SNR_OF2','FaceColor','blue','EdgeColor','blue','EdgeAlpha',transparency,'FaceAlpha',transparency)
% mesh([1:10],[ordem],SNR_OF3','FaceColor','green','EdgeColor','green','EdgeAlpha',transparency,'FaceAlpha',transparency)
% xlabel('n*A_{noise}')
% ylabel('Order')
% zlabel('SNR_{db}')
% legend('SEM restrição ','Com restrição de defasagem','Restrição de defasagem 1ª e 2ª derivadas','Com restrição de pedestal ')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % PLOTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% ord = 7
% plot(a0{ord},'Color',[rand(1) rand(1) rand(1)],'LineWidth',Espessura);
% hold on
% plot(a1{ord},'Color',[rand(1) rand(1) rand(1)],'LineWidth',Espessura);
% plot(a2{ord},'Color',[rand(1) rand(1) rand(1)],'LineWidth',Espessura);
% plot(a3{ord},'Color',[rand(1) rand(1) rand(1)],'LineWidth',Espessura);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% plot(ordem, ones(1,length(ordem))*SNR_base,'x--','Color',[153 153 153]/255,'LineWidth',Espessura,'Displayname','SNR Signal');
% hold on
% 
% if AT(3) == 1;
% plot(ordem,SNR_OF0b,'ko--','LineWidth',Espessura,'Displayname','SNR_{acq} OF (No Immunity)');
% plot(ordem,SNR_OF2b,'ks--','LineWidth',Espessura,'Displayname','SNR_{acq} OF (Pedestal Immunity)');
% end
% 
% if AT(1) == 1;
% plot(ordem,SNR_OF0,'k^--','LineWidth',Espessura,'Displayname','SNR_{sim} OF (No Immunity)');
% plot(ordem,SNR_OF2,'kv--','LineWidth',Espessura,'Displayname','SNR_{sim} OF (Pedestal Immunity)');
% end
% 
% xlabel('Order','FontWeight','bold','FontSize',FontX)
% ylabel('SNR (dB)','FontWeight','bold','FontSize',FontY)
% set(gca,'FontSize',FontAxi);
% % legend_handle = legend('SNR Signal', 'SNR_{acq} OF (No Immunity)', 'SNR_{acq} OF (Pedestal Immunity)',...
% %                        'SNR_{sim} OF (No Immunity)', 'SNR_{sim} OF (Pedestal Immunity)','Location','Best');
% % set(legend_handle, 'FontSize', FontLeg);
% legend show
% SalvarDados('Figura_11', PASTA, Save);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % PLOTS
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(Plots==1)
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% plot(Shape,'ks--','LineWidth',Espessura);
% set(gca,'FontSize',FontAxi);
% 
% SalvarDados('Shape', PASTA, Save);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% plot(s,'ks:','LineWidth',Espessura);
% set(gca,'FontSize',FontAxi);
% hold on
% plot(g{best},s(g{best}),'rs--', 'MarkerEdgeColor','k','MarkerFaceColor','c','LineWidth',Espessura);
% Ylim([-0.1 1.1])
% 
% SalvarDados('sinal_filtro', PASTA, Save);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% plot(s,'ks:','LineWidth',Espessura);
% set(gca,'FontSize',FontAxi);
% hold on
% Ylim([-0.1 1.1])
% for i=1:length(ordem)
%     plot(g{i},s(g{i}),'r*--', 'Color',[rand(1) rand(1) rand(1)],'LineWidth',Espessura);
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% subplot(1,2,1)
% mesh(cov(Noise));
% colormap(Bone)
% set(gca,'FontSize',FontAxi);
% subplot(1,2,2)
% pcolor(cov(Noise));
% colormap(Bone)
% set(gca,'FontSize',FontAxi);
% 
% SalvarDados('Matriz_Covariancia', PASTA, Save);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% subplot(1,2,1)
% mesh((Rij));
% colormap(Jet)
% set(gca,'FontSize',FontAxi);
% subplot(1,2,2)
% pcolor(Rij)
% colormap(Jet)
% set(gca,'FontSize',FontAxi);
% 
% SalvarDados('Matriz_Autoccorelacao', PASTA, Save);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% bin =  calcnbins(max(S'));
% [Hy,xout] = hist(max(S'), bin);
% stairs(xout,Hy,'k','LineWidth',Espessura);
% set(gca,'FontSize',FontAxi);
% hold on
% clear Hy xout;
% bin =  calcnbins(max(Noise'));
% [Hy,xout] = hist(max(Noise'), bin);
% stairs(xout,Hy,'r--','LineWidth',Espessura);
% 
% legend_handle = legend('Signal','Noise','Location','Best');
% set(legend_handle, 'FontSize', FontLeg);
% 
% SalvarDados('Hist_Pico', PASTA, Save);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure('Position',[50 100 scrsz(3)  scrsz(4)])
% subplot(2,1,1)
% plot(S')
% subplot(2,1,2)
% plot(Noise')
% Ylim([min(min(S'))  max(max(S'))])
% 
% 
% end
% 
% 
% disp('******************************************************************');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % Sprintf
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('\nBase  -> mu = %1.5f\tsigma = %1.5f\n',N_mu, N_sigma);
% fprintf('\nRuído -> mu = %1.5f\tsigma = %1.5f\n',Noise_mu, Noise_sigma);
% disp('******************************************************************');
% 
% [muhat,sigmahat] = normfit(max(S'));
% Sinal_mu    = mean(muhat);
% Sinal_sigma = mean(sigmahat);
% fprintf('\nBase  -> mu = %1.5f\tsigma = %1.5f\n',S_mu, S_sigma);
% fprintf('\nSinal -> mu = %1.5f\tsigma = %1.5f\n',Sinal_mu, Sinal_sigma);
% disp('******************************************************************');
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(DiffType==1)    
%     disp('Derivada Discreta');
%     std = 'DD';
% else    
%     disp('Derivada Analitica');
%     std = 'DA';
% end 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(SignalType==1) % desce do pico distribuido para ambos os lados     
%     disp('Sinal de Interesse Decresce do Pico');
% else             % pico ponto incial e final
%     disp('Sinal de Interesse possui os três pontos base');      
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(type==1) % desce do pico distribuido para ambos os lados     
%     disp('Forma de Onda do Sinal Front-End');
%     str = 'Front-End';
% else             % pico ponto incial e final
%     disp('Forma de Onda do Sinal Gaussiano');   
%     str = 'Gaussiana';
% end
% 
% disp('****************************************************************')
% tempo=toc
% 
% 
% clear muhat sigmahat Sinal_mu Sinal_sigma Noise_mu Noise_sigma xout Hy legend_handle;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % saves all variables from the current workspace
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% aux = sprintf('%s',PASTA,'\DataSimulation');
% save(aux);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % Rename
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [pathstr, name, ext] = fileparts(PASTA);
% c = clock;
% % NewFolder = sprintf('%s\\Filtro_Otimo_%s_%s_%1.fh_%1.fmin_%1.fseg',pathstr,str,std,c(4),c(5),c(6));
% NewFolder = PASTA;
% % muda o nome da pasta
% [s,mess,messid] = movefile(PASTA, NewFolder,'f');
% 
