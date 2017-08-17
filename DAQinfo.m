function [sg,bg] = DAQinfo(data,samples,doType)

center = round(samples/2);
base = 256; % 4ns entre amostras do ruído
f = round(base/samples);
%% SEPARAR SINAL E RUÍDO
le = 110;
ld = 180;
range.SG = [round(le/f):round(ld/f)];             % signal range
range.DP = [1:round(le/f) round(ld/f):size(data,1)];   % double peak range
TH = 8e-03;                     % Threshold

ind.sg.TH = find(max(data(range.SG,:))>TH);    % signal selection
ind.sg.DP = find(max(data(range.DP,:))<TH);    % double peak selection
ind.sg.clean = intersect(ind.sg.TH,ind.sg.DP); % signal clean
ind.bg = find(max(data)<TH);                   % background selection

sg.data = data(:,ind.sg.clean); %
sg.A.value = max(sg.data); %


bg.data = data(:,ind.bg);
% figure
% plot(bg.data(:,1:100),'.')
% pause
% figure(100)
% plot(bg.data(:,1),'.r'); hold on
% bg.data = ApplyResolution(bg.data, 128, 2);
% plot(bg.data(:,1),'.k');
% legend('Row','Res')

[sg.A.mu,sg.A.std,sg.A.error.mu,sg.A.error.std]=normfit(max(sg.data));
[bg.mu,bg.std,bg.error.mu,bg.error.std]=normfit(bg.data(:));

bg.pts.mu = mean(bg.data');
bg.pts.std = std(bg.data');

%% CENTRALIZANDO SINAIS PARA O FIT
[sg.datamax] = center_data(sg.data,center,'max');
[sg.datamax] = rmPedestal(sg.datamax,samples);
% figure(101)
% plot(sg.data(:,1:10),'-sr'); hold on
% plot(sg.datamax(:,1:10),'-sk'); hold on
% legend('Row','Res')

% y = mean(sg.datamax');
% ShapeFE=fit([1:128]', [y/max(y)]','gauss1');
% save('ShapeGauss','ShapeFE')
% [ShapeFE] = fitShapeFE(t', [y/max(y)]',1);


% [ShapeGAUSS] = fit([1:128]',data.tr.shape,'gauss1');
% 
% x = 1:128;
% y= ShapeGAUSS.a1.*exp(-((x-ShapeGAUSS.b1)./(1*ShapeGAUSS.c1)).^2);
% plot(x,ShapeGAUSS(x),'k-'); hold on
% plot(x,y,':r')

if doType == 1
    load('ShapeFE.mat')
else
    load('ShapeGauss.mat')
    
    %     [ShapeFE] = FWHMGauss(ShapeFE); % Gaussiana com mesmo FWHM do sinal da FE
    %   load('ShapeGauss.mat')          % Gaussiana qualquer
    ShapeFE = ShapeGauss;
end
sg.ShapeFE = ShapeFE;
% sg.data = ApplyResolution(sg.datamax, 15, 2);

sg.data = sg.datamax;

% figure
% plot(sg.data(:,1:200),'.b'); 
% pause
end