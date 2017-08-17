function [] = plot_single_samples_est(INFO,base)

VSNR = [INFO.EST{1}.filter INFO.EST{1}.base];
STD_VSNR = [INFO.EST{1}.STD.filter INFO.EST{1}.STD.base];

if base.type == 1
    plottitle = ['Order = ' num2str(base.ordem) ' [FE Shape]' ];
else
    plottitle = ['Order = ' num2str(base.ordem) ' [Gaussian Shape]' ];
end

errorbar(VSNR, STD_VSNR, 'sk');hold on
plot(0:0.1:length(VSNR)+1,INFO.EST{1}.base*ones(length(0:0.1:length(VSNR)+1),1),':r')
plot(0:0.1:length(VSNR)+1,zeros(length(0:0.1:length(VSNR)+1),1),':g')
axis tight
xticklabel_rotate([1:length(VSNR)]-0.19,90,{'NO RESTRICTION','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE'},'Interpreter','none')
xlabel('Filters')
ylabel('A_{TRUTH} - A_{EST}')
title(plottitle)

legend('Mean(\pmerror)', 'Baseline', 'Target' , 'Location', 'Best')

end