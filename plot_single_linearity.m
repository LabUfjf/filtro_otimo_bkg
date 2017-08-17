function [] = plot_single_linearity(INFO,base)

cor={'k';'r';'b';'k';'r';'b';'c'};
mark={'o';'o';'o';'+';'+';'+';'p'};

FILTROS = [INFO.OUT{1}.filter{1}; INFO.OUT{1}.base];
% STD_VSNR = [INFO.EST{1}.STD.filter INFO.EST{1}.STD.base];

if base.type == 1
    plottitle = ['Order = ' num2str(base.ordem) ' [FE Shape]' ];
else
    plottitle = ['Order = ' num2str(base.ordem) ' [Gaussian Shape]' ];
end
for i = 1:7
plot(FILTROS(i,:),INFO.OUT{1}.truth,[mark{i} cor{i}]); hold on
end
plot(INFO.OUT{1}.truth,INFO.OUT{1}.truth,['.:']); hold on
% axis tight
legend('AMPLITUDE','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE','TRUTH','Location','Best')
xlabel('A_{EST}(mV)')
ylabel('A_{TRUTH}(mV)')
title(plottitle)
axis tight

end