function [] = plot_mean_std(Amp,out,ordem)

cor={'ok';'or';'ob';'oc';'oy';'og'};

for i=1:length(ordem)
    for j=1:6
        
        data_mean(i,j)=mean(Amp-out{i,j});
        data_std(i,j)=std(Amp-out{i,j});
        
    end
end

Upper=data_mean+data_std;
Lower=data_mean-data_std;
figure
for i=1:6
    errorbar(ordem,data_mean(:,i),data_std(:,i)/sqrt(length(data_std)),['' cor{i}])
    hold on
end

legend('Sem restri��o','Restri��o de fase (1� derivadas)','Restri��o de fase (1� e 2� derivadas)','Restri��o de pedestal','Restri��o de pedestal e fase(1� derivadas)','Restri��o de pedestal e fase(1� e 2� derivadas)','Location','Best')

xlabel('Filter Order')
ylabel('Mean A_{truth}-A_{est}')
grid on
end