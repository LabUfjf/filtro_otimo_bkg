function [] = plot_est(SNRF_NOVA,test,X,Y)

cor={'k';'r';'b';'c';'m';'g';'k'};
mark={'o';'.';'s';'*';'d';'v';'p'};

for k=1:7
    plot(test.Xtick,SNRF_NOVA{k},[':' mark{k} cor{k}]); hold on
    axis tight
    grid on    
    hold on
end
ylabel(X)
xlabel(Y)
legend('NO RESTRICTION','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE', 'Location', 'Best')
end