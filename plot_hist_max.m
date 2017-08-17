function [ ] = plot_hist_max(x,y,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Função plotar o histograma dos máximos do ruído                        %
% Inputs:                                                                 %
%        x - Matriz de ruído Real NxM | N-> Amostras e M->Aquisições      %
%        y - Matriz de ruído Simulado | N-> Amostras e M->Aquisições      %
% Outputs:                                                                %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unidade=1000;     % Passar para MILIVOLTS

% bin_mean = calcnbins(mean(y),'fd');
% bin_max = calcnbins(max(x),'fd');
bin_mean = 100;
bin_max = 40;
ax.mean=linspace(min(unidade*mean(x)),max(unidade*mean(x)),bin_mean);
ax.max=linspace(min(unidade*max(x)),max(unidade*max(x)),bin_max);

[xr.mean,yr.mean,ar.mean.h] = data_normalized(ax.mean,unidade*mean(x));
[xs.mean,ys.mean,as.mean.h] = data_normalized(ax.mean,unidade*mean(y));
[xr.max,yr.max,ar.max.h] = data_normalized(ax.max,unidade*max(x));
[xs.max,ys.max,as.max.h] = data_normalized(ax.max,unidade*max(y));

figure
subplot(1,2,1);stairs(xr.mean,yr.mean,':k');hold on
subplot(1,2,1);stairs(xs.mean,ys.mean,'r')
% subplot(1,2,1); mseb([ xr.mean; xs.mean],[yr.mean; ys.mean], [sqrt(ar.mean.h.y)/ar.mean.h.a; sqrt(as.mean.h.y)/as.mean.h.a],[],1);hold on
legend('Real data','Simulated data')
xlabel('Amplitude (mV)')
ylabel('Events')
title([t ' - Mean Histogram'])
axis tight

subplot(1,2,2);stairs(xr.max(yr.max~=0),yr.max(yr.max~=0),':k');hold on
subplot(1,2,2);stairs(xs.max,ys.max,'r')
% subplot(1,2,2); mseb([ xr.max; xs.max],[yr.max; ys.max], [sqrt(ar.max.h.y)/ar.max.h.a; sqrt(as.max.h.y)/as.max.h.a],[],1);hold on

legend('Real data','Simulated data')
xlabel('Amplitude (mV)')
ylabel('Events')
title([t ' - Max Histogram'])
axis tight
end

