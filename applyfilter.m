function [SNRF,AS,STD_SNR,STD_A] = applyfilter(cf,S,N,Nmax,base)

[~,AS]=MSE_MATRIX_Conv(S,cf,Nmax,base);
[NF,~]=MSE_MATRIX_Conv(N,cf,Nmax,base);
% figure(99)
% hold on
% plot(mean(SF(:,:)'),':.'); hold on
% plot(round(mean(Nmax)),mean(SF(round(mean(Nmax)),:)),'o');
% % %         plot(N(:,1:50),'-or'); hold on
%  pause
% axis([43 47 70.5 72])
%         close

[SNRF,STD_SNR] = SNR(AS,NF,base);

if base.error == 1
    STD_A = std(AS)/sqrt(length(AS));
else
    STD_A = std(AS);
end

end