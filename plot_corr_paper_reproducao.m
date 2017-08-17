load CBPF_FE_Versao_Final_Ruido

corr_canal{1}=corr(Ch1');
corr_canal{2}=corr(Ch2');
corr_canal{3}=corr(Ch3');
corr_canal{4}=corr(Ch4');
corr_canal{5}=corr(Ch5');
corr_canal{6}=corr(Ch6');
corr_canal{7}=corr(Ch7');
corr_canal{8}=corr(Ch8');

for j=1:8
    for i = 1:500
        TEST2(i) = corr_canal{j}(501-i, i);
    end
    diag_corr(j,:)=TEST2;
    clear TEST2
end

for j=1:8
    plot(diag_corr(j,:))
    hold on
end
axis([200 300 -0.2 1.2])
grid on

figure
for j=1:8
eixo_x=linspace(1,hertz,length(diag_corr(j,:)));
semilogx(eixo_x, 20*log10(abs(fft(diag_corr(j,:)))));
axis([1 hertz/2 -60 30])
grid on
hold on
end

diag_med=mean(diag_corr);

eixo_x=linspace(1,hertz,length(diag_med));
semilogx(eixo_x, 20*log10(abs(fft(diag_med))));
axis([1 hertz/2 -60 30])
grid on
hold on

