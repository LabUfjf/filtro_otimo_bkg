load test_bias
cor={'k';'r';'b';'c';'m';'g'};
no = 10;
for i=1:6
%     subplot(1,2,1);    plot(CF{i}{1},[':' cor{i}]); hold on
    %     sum(abs((CF{i}{1})))
    
    subplot(1,1,1);plot(conv(s{no},CF{i}{no}),[':' cor{i}]); hold on
    subplot(1,1,1);plot(filter(CF{i}{no}, 1, st),['-' cor{i}]); hold on
end


%   subplot(1,2,1);legend('Sem restri��o','Restri��o de fase (1� derivadas)','Restri��o de fase (1� e 2� derivadas)','Restri��o de pedestal','Restri��o de pedestal e fase(1� derivadas)','Restri��o de pedestal e fase(1� e 2� derivadas)','Location','Best')
%   subplot(1,2,2);legend('Sem restri��o','Restri��o de fase (1� derivadas)','Restri��o de fase (1� e 2� derivadas)','Restri��o de pedestal','Restri��o de pedestal e fase(1� derivadas)','Restri��o de pedestal e fase(1� e 2� derivadas)','Location','Best')
