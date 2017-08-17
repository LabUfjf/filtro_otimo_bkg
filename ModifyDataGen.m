function [data] = ModifyDataGen(data,Pedestal,NF,setup,bits,doPlot)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DADOS DE treinamento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if bits == 8
% figurevem acompanhados 
% histogram(data.v.A,1000); hold on
% plot(mean(data.v.A),0,'ob')
% A = ApplyResolution(data.v.A, bits, 2);
% histogram(A,1000); 
% plot(mean(A),0,'sr')
% title(['Bits = ' num2str(bits)])
% legend('A','mean(A)','A_{dig}','mean(A_{dig})')
% end


data.mod.tr.bg = NF*data.tr.bg;
% NDAQ
data.mod.tr.NDAQ.bg = ApplyResolution(data.mod.tr.bg, bits, setup);
data.mod.tr.NDAQ.shape = ApplyResolution(data.tr.shape, bits, setup);

% disp('----------DIGIT TR------------- ')
% mean(mean(data.mod.tr.NDAQ.bg))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DADOS DE VALIDAÇÃO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% save data data
% NF = 0;
data.mod.v.all = ( data.v.sg + NF*data.v.bg ) + Pedestal;
data.mod.v.sg = data.v.sg + Pedestal;
data.mod.v.bg = NF*data.v.bg + Pedestal;
% NDAQ
data.mod.v.NDAQ.sg = ApplyResolution(data.mod.v.sg, bits, setup);
data.mod.v.NDAQ.bg = ApplyResolution(data.mod.v.bg, bits, setup);
% disp('----------DIGIT VAL------------- ')
% mean(mean(data.mod.v.NDAQ.bg))
% pause
data.mod.v.NDAQ.all = ApplyResolution(data.mod.v.all, bits, setup);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if doPlot == 1
    ne =randi(length(data.v.sg),1);
 figure
    subplot(3,1,1);stairs(data.mod.v.sg(:,ne),'k'); hold on; stairs(data.mod.v.NDAQ.sg(:,ne),'-r'); legend('RES_{OSC}','RES_{NDAQ}'); title('Signal'); axis tight
    subplot(3,1,2);stairs(data.mod.v.bg(:,ne),'k'); hold on; stairs(data.mod.v.NDAQ.bg(:,ne),'-r'); legend('RES_{OSC}','RES_{NDAQ}'); title('Background'); axis tight
    subplot(3,1,3);stairs(data.mod.v.all(:,ne),'k'); hold on; stairs(data.mod.v.NDAQ.all(:,ne),'-r'); legend('RES_{OSC}','RES_{NDAQ}'); title('Signal+Background'); axis tight
save dataNDAQ data
    pause
end

end