function []=PLOT_default(INFO,base,doPlot)

if size(INFO.SR{1}.filter,1) == 1
    if base.real == 0
        figure; bar_single_default(INFO,base);
        figure; plot_single_default(INFO,base);
        figure; plot_single_linearity(INFO,base);
    else
        bar_single_default(INFO,base);
    end
    
    if doPlot.save == 1
        filename = ['SINGLEDO' num2str(base.ordem) 'T' num2str(base.type) 'R' num2str(base.real) 'U' num2str(base.uniform) 'C' base.ptCONV];
        set(gcf, 'Position', get(0, 'Screensize'));
        currentFolder = [pwd '\Resultados\default\' filename];
        saveas(gcf,currentFolder,'png')
        saveas(gcf,currentFolder,'fig')
    end
    
else
    if base.real == 0
        figure;plot_set_default_snr(INFO,base)
        figure;plot_set_default_est(INFO,base)
        figure;plot_set_default_std(INFO,base)
    else
        plot_set_default_snr(INFO,base)
    end
    
    if doPlot.save == 1
        filename = ['SETDO' num2str(base.ordem(1)) num2str(base.ordem(end)) 'T' num2str(base.type) 'R' num2str(base.real) 'U' num2str(base.uniform) 'C' base.ptCONV];
        set(gcf, 'Position', get(0, 'Screensize'));
        currentFolder = [pwd '\Resultados\default\' filename];
        saveas(gcf,currentFolder,'png')
        saveas(gcf,currentFolder,'fig')
    end
end

