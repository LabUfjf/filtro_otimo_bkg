function [] = bar_single_default(INFO,base)

VSNR = [INFO.SR{1}.filter INFO.SR{1}.base];
STD_VSNR = [INFO.SR{1}.STD.filter INFO.SR{1}.STD.base];

if base.type == 1
    plottitle = ['Order = ' num2str(base.ordem) ' [FE Shape]' ];
else
    plottitle = ['Order = ' num2str(base.ordem) ' [Gaussian Shape]' ];
end

errorbar(VSNR, STD_VSNR, 'sk');hold on
plot(0:0.1:length(VSNR)+1,INFO.SR{1}.base*ones(length(0:0.1:length(VSNR)+1),1),':r')


% bar(VSNR, 'FaceColor', [0.8, 0.8, 0.8]); hold on
% errorbar(VSNR, STD_VSNR, '.k');
% plot(0:0.1:length(VSNR)+1,INFO.SR{1}.base*ones(length(0:0.1:length(VSNR)+1),1),':r')
axis tight
xticklabel_rotate([1:length(VSNR)]-0.19,90,{'AMPLITUDE','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE'})
xlabel({'Filters'},'fontsize',16)
ylabel({'SNR(dB)'},'fontsize',16)
% title(plottitle)

legend('Mean(\pmerror)','Baseline','Location', 'Best')

end