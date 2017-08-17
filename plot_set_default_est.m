function [] = plot_set_default_est(INFO,base)

cor={'krbcmgr'};
mark={'o';'.';'s';'*';'d';'v';'-'};


VSNR = [INFO.EST{1}.filter INFO.EST{1}.base*ones(size(INFO.EST{1}.filter,1),1)];
STD_VSNR = [INFO.EST{1}.STD.filter INFO.EST{1}.STD.base*ones(size(INFO.EST{1}.filter,1),1)];

if base.type == 1
    plottitle = ['FE Shape' ];
else
    plottitle = ['Gaussian Shape' ];
end
    PlotColorDefault(base.ordem,VSNR,'Order','A_{TRUTH} - A_{EST} (mV)');
% for i = 1:size(INFO.SR{1}.filter,2)+1;
%     plot(base.ordem,VSNR(:,i),[mark{i} cor{1}(i)]); hold on
% end
% hold on
% plot(base.ordem,zeros(length(base.ordem),1),'-g')
% legend('NO RESTRICTION','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE','TARGET', 'Location', 'Best')
% axis tight
% xlabel('Order')
% ylabel('A_{TRUTH} - A_{EST} (mV)')
% title(plottitle)
% grid on
end