load test_bias
cor={'k';'r';'b';'c';'m';'g'};
no = 10;
for i=1:6
%     subplot(1,2,1);    plot(CF{i}{1},[':' cor{i}]); hold on
    %     sum(abs((CF{i}{1})))
    
    subplot(1,1,1);plot(conv(s{no},CF{i}{no}),[':' cor{i}]); hold on
    subplot(1,1,1);plot(filter(CF{i}{no}, 1, st),['-' cor{i}]); hold on
end


%   subplot(1,2,1);legend('Sem restrição','Restrição de fase (1ª derivadas)','Restrição de fase (1ª e 2ª derivadas)','Restrição de pedestal','Restrição de pedestal e fase(1ª derivadas)','Restrição de pedestal e fase(1ª e 2ª derivadas)','Location','Best')
%   subplot(1,2,2);legend('Sem restrição','Restrição de fase (1ª derivadas)','Restrição de fase (1ª e 2ª derivadas)','Restrição de pedestal','Restrição de pedestal e fase(1ª derivadas)','Restrição de pedestal e fase(1ª e 2ª derivadas)','Location','Best')
