function [y] = SegundaDerivada(x, type, s, NC)
% Função cria shape Front-End com 'N' pontos
% x são os pontos do shape selecionado
% type define se o shape é gaussiano ou front-end signal

k = 1;

if(type==1) % Front-End    
%A derivada analítica do sinal da Front-end é gerada a partir di sinal s
    ffun = fittype('Gauss6');
    cfun = fit([1:NC]',s',ffun);
    y = (cfun.a1*(2*cfun.b1 - 2*x).^2)./(cfun.c1.^4*exp((cfun.b1 - x).^2./cfun.c1.^2)) - (2*cfun.a2)./(cfun.c2.^2*exp((cfun.b2 - x).^2./cfun.c2.^2)) - (2*cfun.a3)./(cfun.c3.^2*exp((cfun.b3 - x).^2./cfun.c3.^2)) - (2*cfun.a4)./(cfun.c4.^2*exp((cfun.b4 - x).^2./cfun.c4.^2)) - (2*cfun.a5)./(cfun.c5.^2*exp((cfun.b5 - x).^2./cfun.c5.^2)) - (2*cfun.a6)./(cfun.c6.^2*exp((cfun.b6 - x).^2./cfun.c6.^2)) - (2*cfun.a1)./(cfun.c1.^2*exp((cfun.b1 - x).^2./cfun.c1.^2)) + (cfun.a2*(2*cfun.b2 - 2*x).^2)./(cfun.c2.^4*exp((cfun.b2 - x).^2./cfun.c2.^2)) + (cfun.a3*(2*cfun.b3 - 2*x).^2)./(cfun.c3.^4*exp((cfun.b3 - x).^2./cfun.c3.^2)) + (cfun.a4*(2*cfun.b4 - 2*x).^2)./(cfun.c4.^4*exp((cfun.b4 - x).^2./cfun.c4.^2)) + (cfun.a5*(2*cfun.b5 - 2*x).^2)./(cfun.c5.^4*exp((cfun.b5 - x).^2./cfun.c5.^2)) + (cfun.a6*(2*cfun.b6 - 2*x).^2)./(cfun.c6.^4*exp((cfun.b6 - x).^2./cfun.c6.^2));

%     y = y./max(y)*k;
else    
    ffun = fittype('Gauss1');
    cfun = fit([1:NC]',s',ffun);
    y = (cfun.a1*(2*cfun.b1 - 2*x).^2)./(cfun.c1.^4*exp((cfun.b1 - x).^2./cfun.c1.^2)) - (2*cfun.a1)./(cfun.c1.^2*exp((cfun.b1 - x).^2./cfun.c1.^2));  
    
%     y = y./max(y)*k;
end