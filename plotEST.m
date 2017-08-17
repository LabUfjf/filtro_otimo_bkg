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
% legend('Sem restrição','Restrição de fase (1ª derivadas)','Restrição de fase (1ª e 2ª derivadas)','Restrição de pedestal','Restrição de pedestal e fase(1ª derivadas)','Restrição de pedestal e fase(1ª e 2ª derivadas)','Location','Best')
end