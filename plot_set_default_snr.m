function [] = plot_set_default_snr(INFO,base)


% cor={'kkkkkkr'};
% cor=[{[1 0 0]},{[0 0 0]},{[0 1 1]},{[0 0 0]},{[0 1 0]},{[0.8 0.8 0.8]},{[1 0 0]}];
%     mark=[{'o:'},{'*:'},{'^:'},{'+:'},{'s:'},{'v:'},{'-'}];
    
    
    VSNR = [INFO.SR{1}.filter INFO.SR{1}.base*ones(size(INFO.SR{1}.filter,1),1)];
    % STD_VSNR = [INFO.SR{1}.STD.filter INFO.SR{1}.STD.base*ones(size(INFO.SR{1}.filter,1),1)];
    
    if base.type == 1
    plottitle = ['FE Shape' ];
    else
        plottitle = ['Gaussian Shape' ];
    end

    PlotColorDefault(base.ordem,VSNR,'Order','SNR(dB)');
%     for i = 1:size(INFO.SR{1}.filter,2)+1;
%         
%         plot(base.ordem,VSNR(:,i),[mark{i} cor{1}(i)],'MarkerSize',4); hold on
%     end
    
%     legend('AMPLITUDE','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','BASE', 'Location', 'Best')
%     axis tight
%     xlabel('Order')
%     ylabel('SNR(dB)')
%     title(plottitle)
%     grid on
end