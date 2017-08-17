function [] = COEFdebug(CF,s,g,gL,gL2,ordem)

L=[{'Sem restri��o'} {'Restri��o de fase (1� derivadas)'} {'Restri��o de fase (1� e 2� derivadas)'} {'Restri��o de pedestal'} {'Restri��o de pedestal e fase(1� derivadas)'} {'Restri��o de pedestal e fase(1� e 2� derivadas)'}];

figure
for i = 1:6
    
    for j = 1:length(ordem)
        
        D(i,:)= CF{1}{j}-CF{i}{j};
        
        G{i}=s(g{j})';
        GL{i}=gL{i}{j}';
        GL2{i}=gL2{i}{j}';
       
        R.n1{i}{j}=sum(CF{i}{j}.*s(g{j})');
        R.n2{i}{j}=sum(CF{i}{j}.*gL{i}{j}');
        R.n3{i}{j}=sum(CF{i}{j}.*gL2{i}{j}');
        R.n4{i}{j}=sum(CF{i}{j});
        
        figure(100)
        subplot(2,3,i);plot(ordem(j),R.n1{i}{j},'+k');hold on; axis tight; grid on;
        subplot(2,3,i);plot(ordem(j),R.n2{i}{j},'ob');hold on; axis tight; grid on;
        subplot(2,3,i);plot(ordem(j),R.n3{i}{j},'sm');hold on; axis tight; grid on;
        subplot(2,3,i);plot(ordem(j),R.n4{i}{j},'dr');hold on; axis tight; grid on;
        
        subplot(2,3,i); legend('\Sigmaa_ig_i=1','\Sigmaa_ig''_i=0','\Sigmaa_ig''''_i=0','\Sigmaa_i=0')
        title([L{i}]); xlabel('Ordem'); ylabel('Valor da Restri��o')
        
        figure(101)
        subplot(2,3,i);plot(ordem(j),1-R.n1{i}{j},'+k');hold on; axis tight; grid on;
        subplot(2,3,i);plot(ordem(j),R.n2{i}{j},'ob');hold on; axis tight; grid on;
        subplot(2,3,i);plot(ordem(j),R.n3{i}{j},'sm');hold on; axis tight; grid on;
        subplot(2,3,i);plot(ordem(j),R.n4{i}{j},'dr');hold on; axis tight; grid on;
        
        subplot(2,3,i); legend('\Delta\Sigmaa_ig_i=1','\Delta\Sigmaa_ig''_i=0','\Delta\Sigmaa_ig''''_i=0','\Delta\Sigmaa_i=0')
        title([L{i}]); xlabel('Ordem'); ylabel('Valor da Restri��o')
    end
end


save ShapeDeriv G GL GL2
pause

end
% figure
% bar(D(2:end,:)')
% legend('Phase','Phase(2Diff)','Pedestal','Pedestal(2Diff)','Phase/Pedestal(2Diff)')
% pause