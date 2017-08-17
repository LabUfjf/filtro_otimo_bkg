function [y,std_snr] = SNR(AS, Noise,base)

%% SNR
R=(Noise);
Noise_mu=mean(R(:));
mu = mean(AS)-Noise_mu;
[sigmaN] = std(R(:));
y = 20*log10(mu/sigmaN);

%% DESVIDO PADRÃO DO SNR
Noise = Noise(:,1:min([length(Noise) length(AS)]));
mu_evt = AS-Noise_mu;
std_noise_evt=std(Noise);
% save std_noise_evt std_noise_evt
y_evt = 20*log10(mu_evt(std_noise_evt~=0)./std_noise_evt(std_noise_evt~=0));

if base.error == 1
    std_snr = std(y_evt)/sqrt(length(y_evt));
else
    std_snr = std(y_evt);
end
