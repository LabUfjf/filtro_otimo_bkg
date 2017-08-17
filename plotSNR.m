function [] = plotSNR(SNRF_NOVA,test,base)

cor={'k';'r';'b';'c';'m';'g'};
mark={'+';'o';'*';'square';'diamond';'>'};
figure
for k=1:6
    if size(abs(SNRF_NOVA{k}),2) == 1
        subplot(1,1,1);h=plot(test.Xtick,abs(SNRF_NOVA{k}),[cor{k}]);
    else
        subplot(1,1,1);h=plot(test.Xtick,abs(SNRF_NOVA{k}),[cor{k}]); hold on
%         set(h,'FaceColor','None','LineStyle','None','Marker',mark{k},'MarkerEdgeColor',cor{k})
    end
    axis tight
    grid on
    
    hold on
end

% ax = gca;
% ax.XTick = test.Xtick;
% ax.YTick = base.ordem;
% zlabel('SNR(db)')
% ylabel('SNR(db)')
% xlabel(test.Xlabel)

legend('Sem restrição','Restrição de fase (1ª derivadas)','Restrição de fase (1ª e 2ª derivadas)','Restrição de pedestal','Restrição de pedestal e fase(1ª derivadas)','Restrição de pedestal e fase(1ª e 2ª derivadas)','Location','Best')
end