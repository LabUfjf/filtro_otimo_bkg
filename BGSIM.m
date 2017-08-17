function [n] = BGSIM(data,NP,N)

[a,b]=size(NP.pts.mu');

[ matrix ] = MeanCorr( cov(data') );
% matrix=cov(data');
% figure
% subplot(1,2,1);mesh(matrix); axis tight
% subplot(1,2,2);mesh(cov(data'));axis tight
% pause
n = mvnrnd(zeros(a,b),matrix,N)';

% zeros(a,b)
% pause
% disp('--------ANALOG----------')
% mean(mean(n))
% pause
% R= n(:);

end