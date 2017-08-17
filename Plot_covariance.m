function [] = Plot_covariance(NoiseReal,NoiseSim)

cov_NR=cov(NoiseReal');
cov_NS=cov(NoiseSim');
tam=length(cov_NR);
% cov_NR_norm=cov_NR/(max(max(cov_NR)));
% cov_NS_norm=cov_NS/(max(max(cov_NS)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT REAL DATA
figure
surf(cov_NR)

colormap('jet')
legend({'Real data'},'FontSize',14,'Location','north')
% legend('Simulated data')
xlabel('ADC Counts','FontSize',16)
ylabel('ADC Counts','FontSize',16)
zlabel('Covariance','FontSize',16)
set(gcf, 'Position', get(0, 'Screensize'));
az = 25;
el = 30;
view(az, el);
axis([0 tam 0 tam min(min(cov_NR)) max(max(cov_NR))])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT SIMULATED DATA

figure
mesh(cov_NS)

colormap('jet')
legend({'Simulated data'},'FontSize',14,'Location','north')
% legend('Simulated data')
xlabel('ADC Counts','FontSize',16)
ylabel('ADC Counts','FontSize',16)
zlabel('Covariance','FontSize',16)
set(gcf, 'Position', get(0, 'Screensize'));
az = 25;
el = 30;
view(az, el);
axis([0 tam 0 tam min(min(cov_NS)) max(max(cov_NS))])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% transparency=0.5;
% 
% figure
% mesh(cov_NR)
% figure
% mesh(cov_NR')
% % mesh(cov_NR,'FaceColor','red','EdgeColor','red','EdgeAlpha',transparency,'FaceAlpha',transparency);axis tight
% legend('REAL');
% 
% figure
% mesh(cov_NS)
% % mesh(cov_NS,'FaceColor','blue','EdgeColor','blue','EdgeAlpha',transparency,'FaceAlpha',transparency);axis tight
% legend('SIMULATED');
% % % mesh(abs(cov_NR-cov_NS),'FaceColor','green','EdgeColor','green','EdgeAlpha',transparency,'FaceAlpha',transparency)
% % % legend('REAL','SIMULATED','DIFF=REAL-SIM'); title('COVARIANCE MATRIX');
% axis tight

end