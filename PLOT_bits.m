function []= PLOT_bits(INFO,base,test,doPlot)

[MATRIX.SR]=SNRreshape(INFO,'SNR');
[MATRIX.EST]=SNRreshape(INFO,'EST');
[MATRIX.STD]=SNRreshape(INFO,'STD');

figure; PlotColorDefaultCell(test.Xtick,MATRIX.SR,'BITS','SNR(dB)');
figure; PlotColorDefaultCell(test.Xtick,MATRIX.EST,'BITS','A_{TRUTH} - A_{EST} (mV)');
figure; PlotColorDefaultCell(test.Xtick,MATRIX.STD,'BITS','ERROR');

% subplot(1,3,1);plot_snr(MATRIX.SR,test,'SNR(dB)','BITS');
% subplot(1,3,2);plot_est(MATRIX.EST,test,'A_{TRUTH} - A_{EST} (mV)','BITS')
% subplot(1,3,3);plot_est(MATRIX.STD,test,'STD_{EST}','BITS')

if doPlot.save == 1
    filename = ['BITSO' num2str(base.ordem) 'T' num2str(base.type) 'R' num2str(base.real) 'U' num2str(base.uniform) 'C' base.ptCONV];
    set(gcf, 'Position', get(0, 'Screensize'));
    currentFolder = [pwd '\Resultados\bits\' filename];
    saveas(gcf,currentFolder,'png')
    saveas(gcf,currentFolder,'fig')
end

end