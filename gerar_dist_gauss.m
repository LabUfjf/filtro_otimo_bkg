function [ electron,jet ] = gerar_dist_gauss(mean_e, std_e, mean_j, std_j, ne,nj, dist)
% % ELECTRON
% ne=60000;
% mean_e=0.0108;
% std_e=0.0011;
% 
% %JET
% nj=1800000;
% mean_j=0.0127;
% std_j=0.025;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
electron = random(dist,mean_e,std_e,1,ne); 
jet = random(dist,mean_j,std_j,1,nj);

end

