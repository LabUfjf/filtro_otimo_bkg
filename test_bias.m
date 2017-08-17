
close all; clear all; clc
load test_bias
load Ac
L=[{'Sem restrição'} {'Restrição de fase (1ª derivadas)'} {'Restrição de fase (1ª e 2ª derivadas)'} {'Restrição de pedestal'} {'Restrição de pedestal e fase(1ª derivadas)'} {'Restrição de pedestal e fase(1ª e 2ª derivadas)'}];
format long

for f = 1:6;          %filtro 1:6
    qo = 1;         %qtde de ordens do teste
    for ne = 1:1000;         %numero do evento testado
    p = 1;
    Ac = Atest(f,ne);
    ai =CF{f}{qo};
    g = s{1};
    
    P1 = sum(ai.*g');
    P2 = sum(ai.*gL{f}{qo}');
    P3 = sum(ai.*gL2{f}{qo}');
    P4 = sum(ai.*n{qo}');
    
    P1(isnan(P1))=0;
    P2(isnan(P2))=0;
    P3(isnan(P3))=0;
    P4(isnan(P4))=0;
    
    A_est = A(ne)*P1 - A(ne)*tau(p)*P2 + A(ne)*[(tau(p)^2)/2]*P3+P4;
    VR = [1-P1 P2 P3 P4 1-P1+P2+P3+P4];
     subplot(2,3,f);bar(VR);hold on; axis tight; grid on;
    %     title([L{f}]); xlabel('Restrição'); ylabel('Valor da Restrição')
    d1{f}(ne)=Ac-A(ne);
    d2{f}(ne)=A_est-A(ne);    
    end
    disp(['\Ac=' num2str(mean(d1{f}),10) ' \A_est=' num2str(mean(d2{f}),10)])
end




%E[A] =  A*sum(ai*g) - A*tau*sum(ai*gLi) + A*[(tau^2)/2]*sum(ai*gL2i) + sum(ai*E[ni])