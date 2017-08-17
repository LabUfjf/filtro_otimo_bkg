function [] = plot_set_default_std(INFO,base)

cor={'krbcmgr'};
mark={'o';'.';'s';'*';'d';'v';'-'};


% VSNR = [INFO.EST{1}.filter INFO.EST{1}.base*ones(size(INFO.EST{1}.filter,1),1)]*1e3;
VSNR = [INFO.EST{1}.STD.filter INFO.EST{1}.STD.base*ones(size(INFO.EST{1}.filter,1),1)];
PlotColorDefault(base.ordem,VSNR,'Order','ERROR');
% if base.type == 1
%     plottitle = ['FE Shape' ];
% else
%     plottitle = ['Gaussian Shape' ];
% end
% 
% for i = 1:size(INFO.SR{1}.filter,2)+1;
%     plot(base.ordem,VSNR(:,i),[mark{i} cor{1}(i)]); hold on
% end
% legend('NO RESTRICTION','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE', 'Location', 'Best')
% axis tight
% xlabel('Order')
% ylabel('STD')
% title(plottitle)
% grid on
end