function [ Rxx ] = MeanSpectrumPower( x,hertz )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Função para calculo do Espetro de Potência Médio do Ruído              %
% Inputs:                                                                 %
%        x - Matriz de ruído NxM | N-> Amostras e M->Aquisições           %
%                                                                         %
% Outputs:                                                                %
%        mean_cov_x_shift - Média do Espectro de Potência                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
corr_x=corr(x');
% corr_x=x;
[a,~]=size(corr_x);

for j=0:(a-1);
    k1=1;
    k2=1;
    aux1=0;
    aux2=0;
    for i=1:(a-j)
        if(~isnan(corr_x(i+(j), i)))
            teste2(k1) = corr_x(i+(j), i);
            k1=k1+1;
            aux1=1;
        end
        if(~isnan(corr_x(i, i+(j))))
            teste4(k2) = corr_x(i, i+(j));
            k2=k2+1;
            aux2=1;
        end
    end
    if(aux1==1)
        teste3{j+1}=teste2;
    end
    if(aux2==1)
        teste5{j+1}=teste4;
    end
    clear teste2 teste4;
end

for k=1:a
    corr_media1(k)=mean(teste3{k});
    corr_media2(k)=mean(teste5{k});
end

Rxx=[corr_media2(a-(0:(a-1))) corr_media1(2:end)];
% figure
% hold on
% subplot(2,1,1)
% plot(Rxx,'k')
% xlabel('Time (samples)')
% ylabel('Autocorrelation Coefficient')
% axis tight
% grid on
figure
hold on
eixo_x=linspace(1,hertz,length(Rxx));
eixo_y=20*log10(abs(fft(Rxx)));
semilogx(eixo_x(1:round(end/2)-2), eixo_y(1:round(end/2)-2),'k');
axis([1 hertz/2 -60 30])
grid on
xlabel('Frequency(MHz)','FontSize',16)
ylabel('Power (dB)','FontSize',16)
axis tight