function []= PLOT_pileup(INFO,base,test,doPlot)

[MATRIX.SR]=SNRreshape(INFO,'SNR');
[MATRIX.EST]=SNRreshape(INFO,'EST');
[MATRIX.STD]=SNRreshape(INFO,'STD');


figure; PlotColorDefaultCell(test.Xtick,MATRIX.SR,'Events Frequency','SNR(dB)');
figure; PlotColorDefaultCell(test.Xtick,MATRIX.EST,'Events Frequency','A_{TRUTH} - A_{EST} (mV)'); 
% set(gca,'YScale','Log')
figure; PlotColorDefaultCell(test.Xtick,MATRIX.STD,'Events Frequency','STD');

if doPlot.save == 1
    filename = ['PILEUPO' num2str(base.ordem) 'T' num2str(base.type) 'R' num2str(base.real) 'U' num2str(base.uniform) 'C' base.ptCONV];
    set(gcf, 'Position', get(0, 'Screensize'));
    currentFolder = [pwd '\Resultados\pileup\' filename];
    saveas(gcf,currentFolder,'png')
    saveas(gcf,currentFolder,'fig')
end

end