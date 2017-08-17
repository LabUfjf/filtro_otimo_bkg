function []=plot_set_samples_snr(INFO,base)

if length(INFO.EST) == 3
    base.ordem = 5:1:256-1;
    amostras = [64 128 256]-base.ordem(1);
else
    base.ordem = 5:1:128-1;
    amostras = [64 128]-base.ordem(1);
end

cor={'krbcmgr'};
mark={'o';'.';'s';'*';'d';'v';'-'};

if base.type == 1
    plottitle = ['FE Shape' ];
else
    plottitle = ['Gaussian Shape' ];
end


for i = 1:length(amostras)
    
%     VSNR = [INFO.SR{i}.filter INFO.SR{i}.base*ones(size(INFO.SR{i}.filter,1),1)];
    STD_VSNR = [INFO.SR{1}.STD.filter INFO.SR{1}.STD.base*ones(size(INFO.SR{1}.filter,1),1)];
    
   figure; PlotColorDefault(base.ordem(1:amostras(i)),STD_VSNR,'Order','ERROR');
    
%     for j = 1:size(INFO.SR{i}.filter,2)+1;
%         subplot(2,length(amostras),i);plot(base.ordem(1:amostras(i)),VSNR(:,j),[mark{j} cor{1}(j)]); hold on;
%     end
%     axis tight
%     xlabel('Order')
%     ylabel('SNR(dB)')
%     grid on
    %     axis([20 amostras(i) 33 38])
    %    title([plottitle '- ' num2str(amostras(i)) ' Samples'] )
    legend('AMPLITUDE','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE', 'Location', 'Best')
    
end
