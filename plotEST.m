function [EST] = plotEST(ATRUTH,AEST,ordem)

cor={'k';'r';'b';'c';'m';'g'};
mark={'+';'o';'*';'square';'diamond';'>'};

for k=1:6
%     figure(100)
    EST(k) = mean(ATRUTH-AEST(k,:));
%     subplot(2,1,2);plot(ordem, EST(k),['o' cor{k}])
%     axis tight
%     grid on    
%     hold on
end

% ax = gca;
% ax.XTick = test.Xtick;
% x.XTick = ordem;
% % zlabel('SNR(db)')
% ylabel('Filter Order')
% xlabel(test.Xlabel)
% ylabel('ATRUTH-AEST')
% legend('Sem restri��o','Restri��o de fase (1� derivadas)','Restri��o de fase (1� e 2� derivadas)','Restri��o de pedestal','Restri��o de pedestal e fase(1� derivadas)','Restri��o de pedestal e fase(1� e 2� derivadas)','Location','Best')
end