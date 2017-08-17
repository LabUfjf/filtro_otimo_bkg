function []=PLOT_samples(INFO,base,doPlot)


% plot_set_samples_snr(INFO,base);
plot_set_samples_est(INFO,base);

if doPlot.save == 1
filename = ['SAMPLESO' num2str(base.ordem) 'T' num2str(base.type) 'R' num2str(base.real) 'U' num2str(base.uniform) 'C' base.ptCONV]; 
set(gcf, 'Position', get(0, 'Screensize'));
currentFolder = [pwd '\Resultados\samples\' filename];
saveas(gcf,currentFolder,'png')
saveas(gcf,currentFolder,'fig')
end

end