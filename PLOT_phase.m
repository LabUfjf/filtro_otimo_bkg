function [] = PLOT_phase(INFO,base,test,doPlot)


[MATRIX.SR]=SNRreshape(INFO,'SNR');
[MATRIX.EST]=SNRreshape(INFO,'EST');
[MATRIX.STD]=SNRreshape(INFO,'STD');

figure; PlotColorDefaultCell(test.Xtick,MATRIX.SR,'Phase(Radian)','SNR(dB)');
figure; PlotColorDefaultCell(test.Xtick,MATRIX.EST,'Phase(Radian)','A_{TRUTH} - A_{EST} (mV)');
figure; PlotColorDefaultCell(test.Xtick,MATRIX.STD,'Phase(Radian)','ERROR');
% subplot(1,3,1);plot_snr(MATRIX.SR,test,'SNR(dB)','Phase');
% subplot(1,3,2);plot_est(MATRIX.EST,test,'A_{TRUTH} - A_{EST}','Phase')
% subplot(1,3,3);plot_est(MATRIX.STD,test,'ERROR','Phase')

if doPlot.save == 1
    filename = ['PHASEO' num2str(base.ordem) 'T' num2str(base.type) 'R' num2str(base.real) 'U' num2str(base.uniform) 'C' base.ptCONV];
    set(gcf, 'Position', get(0, 'Screensize'));
    currentFolder = [pwd '\Resultados\phase\' filename];
    saveas(gcf,currentFolder,'png')
    saveas(gcf,currentFolder,'fig')
end
end