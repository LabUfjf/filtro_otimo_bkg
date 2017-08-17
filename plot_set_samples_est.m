function [] = plot_set_samples_est(INFO,base)



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
    VSNR = [INFO.EST{i}.filter INFO.EST{i}.base*ones(size(INFO.EST{i}.filter,1),1)];
    STD_VSNR = [INFO.EST{i}.STD.filter INFO.EST{i}.STD.base*ones(size(INFO.EST{i}.filter,1),1)];
       figure; PlotColorDefault(base.ordem(1:amostras(i)),STD_VSNR,'Order','ERROR');
%     for j = 1:size(INFO.SR{i}.filter,2)+1;
%         subplot(2,length(amostras),2+i);plot(base.ordem(1:amostras(i)),VSNR(:,j),[mark{j} cor{1}(j)]); hold on
%     end
%     hold on
%     plot(base.ordem(1:amostras(i)),zeros(length(base.ordem(1:amostras(i))),1),'-g')
%     legend('AMPLITUDE','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE', 'Location', 'Best')
    axis tight
%     xlabel('Order')
%     ylabel('A_{TRUTH} - A_{EST}')
%      title([plottitle '- ' num2str(amostras(i)) ' Samples'] )
    grid on
end

end