function []= PLOTOF(INFO,test,base,doPlot)

if strcmp(test.variable,'default');
    PLOT_default(INFO,base,doPlot);
end

if strcmp(test.variable,'amostras');
    PLOT_samples(INFO,base,doPlot);
end

if strcmp(test.variable,'phase');
    PLOT_phase(INFO,base,test,doPlot);    
end

if strcmp(test.variable,'pedestal');
    PLOT_pedestal(INFO,base,test,doPlot);
end

if strcmp(test.variable,'NF');
    PLOT_NF(INFO,base,test,doPlot);    
end

if strcmp(test.variable,'bits');
    PLOT_bits(INFO,base,test,doPlot);    
end

if strcmp(test.variable,'pileup');
    PLOT_pileup(INFO,base,test,doPlot);    
end

end