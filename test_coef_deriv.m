% teste coef_deriv
close all; clear variables; clc;
%% ESCOLHER TIPO DE PDF:
kind = 'LogN'; % 'Normal' | 'LogN' | 'Rayleigh' | 'Weibull'
inter = 'linear';
k = 0;
nd = 5;
range = 0.05:0.001:0.5;

for f = range;
    k=k+1;
    
    [x.N,y.N,h.N,mu.N] = GeneratePDF('Normal',f);
    [x.L,y.L,h.L,mu.L] = GeneratePDF('LogN',f);
    
    [d.N,x.N] = deriv(x.N,y.N,h.N,nd);
    [d.L,x.L] = deriv(x.L,y.L,h.L,nd);
    
    [C.N] = coefGen(d.N);
    [C.L] = coefGen(d.L);
    
    for i = 1:nd
        D.N(i)=sum((C.N.A{i+1}-C.N.A{i}));
        D.L(i)=sum((C.L.A{i+1}-C.L.A{i}));
    end
    
    MD.N(k,:)=D.N;
    MD.L(k,:)=D.L;
end

subplot(2,3,1);plot(range,MD.N(:,1),'r'); axis tight; hold on;
subplot(2,3,2);plot(range,MD.N(:,2),'g'); axis tight;hold on;
subplot(2,3,3);plot(range,MD.N(:,3),'b'); axis tight;hold on;
subplot(2,3,4);plot(range,MD.N(:,4),'k'); axis tight;hold on;
subplot(2,3,5);plot(range,MD.N(:,5),'m'); axis tight;hold on;

subplot(2,3,1);plot(range,MD.L(:,1),':r'); axis tight;
subplot(2,3,2);plot(range,MD.L(:,2),':g'); axis tight;
subplot(2,3,3);plot(range,MD.L(:,3),':b'); axis tight;
subplot(2,3,4);plot(range,MD.L(:,4),':k'); axis tight;
subplot(2,3,5);plot(range,MD.L(:,5),':m'); axis tight;

subplot(2,3,1);ylabel('Coef(d1-Sem Derivada)');legend('Normal','LogNormal');xlabel('Std');
subplot(2,3,2);ylabel('Coef(d2-d1)');legend('Normal','LogNormal');xlabel('Std');
subplot(2,3,3);ylabel('Coef(d3-d2)');legend('Normal','LogNormal');xlabel('Std');
subplot(2,3,4);ylabel('Coef(d4-d3)');legend('Normal','LogNormal');xlabel('Std');
subplot(2,3,5);ylabel('Coef(d5-d4)');legend('Normal','LogNormal');xlabel('Std');
% [se,sd] = simmetry(x,h,mu,d);
%
% figure
%     c = ['kgmcbr'];
%
% for i = 1:length(d.y)
% subplot(1,2,1);plot(x,d.da{i+1},'-.','color',c(i+1)); hold on  ; axis tight
% end
% subplot(1,2,1); legend('d1','d2','d3','d4','d5')
%
% for i = 1:length(d.y)+1
% subplot(1,2,2);plot(x,C.A{i},'-.','color',c(i)); hold on ; axis tight
% end
% subplot(1,2,2); legend('Sem derivada','d1','d2','d3','d4','d5');

% figure
% subplot(1,2,1);bar([se; sd]'); axis tight
% subplot(1,2,2);bar([se-sd]'); axis tight
