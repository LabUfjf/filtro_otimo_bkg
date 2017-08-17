close all; clc; clear variables;
%% TESTE SIMETRIA

AMPLITUDE = 1;
NORMAL = 1;

n = 2^10;
samples = n;
order = n;
inter = 'linear';
npi = 2000;

if NORMAL == 1;
    li = -10;
    ls = 10;
    sigma = 1;
    mu = 0;
else
    li = 0;
    ls = 10;
    sigma =2;
    mu = -0;
end


x = linspace(li,ls,samples);


%% Correção para pico ficar no centro da amostragem


%  g = cos(x);

if NORMAL == 1;
    g = (1/sqrt(2*pi*(sigma^2)))*exp(-((x-mu).^2)/(2*(sigma^2))); % normal
else
%     g = (1/sqrt(2*pi*(sigma^2)))*exp(-((x-mu).^2)/(2*(sigma^2)))+1*(1/sqrt(2*pi*(6^2)))*exp(-((x-0).^2)/(2*(6^2))); % normal
        g = (1./(x.*sigma*sqrt(2*pi))).*exp(-((log(x)-mu).^2)/(2*(sigma^2)));
end

g = g/max(g)-0.5;

% [~,b]=sort(g,'descend');
% b = b(1:order);
% ind=sort(b)';
ind = 1:order;

xd = linspace(min(x),max(x),npi); h = diff(xd); h = h(1);

if NORMAL == 1
    %   yd = cos(xd);
    yd = (1/sqrt(2*pi*(sigma^2)))*exp(-((xd-mu).^2)/(2*(sigma^2))); % normal
else
%     yd = (1/sqrt(2*pi*(sigma^2)))*exp(-((xd-mu).^2)/(2*(sigma^2)))+1*(1/sqrt(2*pi*(6^2)))*exp(-((xd-0).^2)/(2*(6^2)));
      yd = (1./(xd.*sigma*sqrt(2*pi))).*exp(-((log(xd)-mu).^2)/(2*(sigma^2)));
end

yd = yd/max(yd)-0.5;

dd1 = diff(yd)/h; dd2 = diff(dd1)/h; dd3 = diff(dd2)/h; dd4 = diff(dd3)/h;  dd5 = diff(dd4)/h; dd6 = diff(dd5)/h; dd7 = diff(dd6)/h;
g1 = interp1(xd,[dd1 0],x,inter);
g2 = interp1(xd,[dd2 0 0],x,inter);
g3 = interp1(xd,[dd3 0 0 0],x,inter);
g4 = interp1(xd,[dd4 0 0 0 0],x,inter);
g5 = interp1(xd,[dd5 0 0 0 0 0],x,inter);
% g6 = interp1(xd,[dd6 0 0 0 0 0 0],x,'linear');
% g7 = interp1(xd,[dd7 0 0 0 0 0 0 0],x,'linear');

figure(1)
subplot(1,3,2);plot(x(ind),g1(ind),'-r',x(ind),g2(ind),'-b',x(ind),g3(ind),'-g',x(ind),g4(ind),'-m',x(ind),g5(ind),'-c')
% subplot(1,2,1);plot(x,g1,'-r',x,g2,'-b',x,g3,'-g',x,g4,'-m',x,g5,'-c',x,g6,'-y',x,g7,'-k')
% legend('d1','d2','d3','d4','d5','d6','d7'); axis tight ; title('Derivadas')
legend('d1','d2','d3','d4','d5'); axis tight ; title('Derivadas')


figure(1)
subplot(1,3,1);plot(x(ind),g(ind),'.:k'); axis tight; title('Shape')

R = eye(order);

A = [R g(ind)';
    g(ind) zeros(1,1)];

AD = [R g(ind)' g1(ind)';
    g(ind) zeros(1,2)
    g1(ind) zeros(1,2)];

AD2 = [R g(ind)' g1(ind)' g2(ind)';
    g(ind) zeros(1,3)
    g1(ind) zeros(1,3)
    g2(ind) zeros(1,3)];

AD3 = [R g(ind)' g1(ind)' g2(ind)' g3(ind)';
    g(ind) zeros(1,4)
    g1(ind) zeros(1,4)
    g2(ind) zeros(1,4)
    g3(ind) zeros(1,4)];

AD4 = [R g(ind)' g1(ind)' g2(ind)' g3(ind)'  g4(ind)';
    g(ind) zeros(1,5)
    g1(ind) zeros(1,5)
    g2(ind) zeros(1,5)
    g3(ind) zeros(1,5)
    g4(ind) zeros(1,5)];

AD5 = [R g(ind)' g1(ind)' g2(ind)' g3(ind)'  g4(ind)' g5(ind)';
    g(ind) zeros(1,6)
    g1(ind) zeros(1,6)
    g2(ind) zeros(1,6)
    g3(ind) zeros(1,6)
    g4(ind) zeros(1,6)
    g5(ind) zeros(1,6)];

% AD6 = [R g(ind)' g1(ind)' g2(ind)' g3(ind)'  g4(ind)' g5(ind)' g6(ind)';
%     g(ind) zeros(1,7)
%     g1(ind) zeros(1,7)
%     g2(ind) zeros(1,7)
%     g3(ind) zeros(1,7)
%     g4(ind) zeros(1,7)
%     g5(ind) zeros(1,7)
%     g6(ind) zeros(1,7)];
%
% AD7 = [R g(ind)' g1(ind)' g2(ind)' g3(ind)'  g4(ind)' g5(ind)' g6(ind)' g7(ind)';
%     g(ind) zeros(1,8)
%     g1(ind) zeros(1,8)
%     g2(ind) zeros(1,8)
%     g3(ind) zeros(1,8)
%     g4(ind) zeros(1,8)
%     g5(ind) zeros(1,8)
%     g6(ind) zeros(1,8)
%     g7(ind) zeros(1,8)];

if AMPLITUDE == 1
    B = [zeros(order,1) ;1];
    BD = [zeros(order,1) ;1 ;0];
    BD2 = [zeros(order,1) ;1 ;0; 0];
    BD3 = [zeros(order,1) ;1 ;0; 0; 0];
    BD4 = [zeros(order,1) ;1 ;0; 0; 0; 0];
    BD5 = [zeros(order,1) ;1 ;0; 0; 0; 0; 0];
    % BD6 = [zeros(order,1) ;1 ;0; 0; 0; 0; 0; 0];
    % BD7 = [zeros(order,1) ;1 ;0; 0; 0; 0; 0; 0; 0];
else
    B = [zeros(order,1) ;0];
    BD = [zeros(order,1) ;0 ;-1];
    BD2 = [zeros(order,1) ;0 ;-1; 0];
    BD3 = [zeros(order,1) ;0 ;-1; 0; 0];
    BD4 = [zeros(order,1) ;0 ;-1; 0; 0; 0];
    BD5 = [zeros(order,1) ;0 ;-1; 0; 0; 0; 0];
    % BD6 = [zeros(order,1) ;0 ;-1; 0; 0; 0; 0; 0];
    % BD7 = [zeros(order,1) ;0 ;-1; 0; 0; 0; 0; 0; 0];
end

X = linsolve(A,B);
XD = linsolve(AD,BD);
XD2 = linsolve(AD2,BD2);
XD3 = linsolve(AD3,BD3);
XD4 = linsolve(AD4,BD4);
XD5 = linsolve(AD5,BD5);
% XD6 = linsolve(AD6,BD6);
% XD7 = linsolve(AD7,BD7);

X = X(1:end-1);
XD = XD(1:end-2);
XD2 = XD2(1:end-3);
XD3 = XD3(1:end-4);
XD4 = XD4(1:end-5);
XD5 = XD5(1:end-6);
% XD6 = XD6(1:end-7);
% XD7 = XD7(1:end-8);

figure(1)
subplot(1,3,3);plot(x(ind),X,':ok',x(ind),XD,':.r',x(ind),XD2,':sb',x(ind),XD3,':+g',x(ind),XD4,':sm',x(ind),XD5,':*c')
% subplot(1,2,2);plot(1:order,X,'ok',1:order,XD,'.r',1:order,XD2,'sb',1:order,XD3,'+g',1:order,XD4,'sm',1:order,XD5,'*c',1:order,XD6,'^y',1:order,XD7,'vk')
% legend('Sem derivada','d1','d2','d3','d4','d5','d6','d7'); title('Coeficientes')
legend('Sem derivada','d1','d2','d3','d4','d5'); title('Coeficientes')
axis tight

figure


xe= x(1:(samples/2)-1);
xd= x((samples/2)+1:end);

xe = linspace(min(xe),max(xe),round(npi/2));
xd = linspace(min(xd),max(xd),round(npi/2));

re = (1:length(xe));
rd = (1:length(xd));

ie1 = interp1(x,g1,xe(re),'linear');
ie2 = interp1(x,g2,xe(re),'linear');
ie3 = interp1(x,g3,xe(re),'linear');
ie4 = interp1(x,g4,xe(re),'linear');
ie5 = interp1(x,g5,xe(re),'linear');

id1 = interp1(x,g1,xd(rd),'linear');
id2 = interp1(x,g2,xd(rd),'linear');
id3 = interp1(x,g3,xd(rd),'linear');
id4 = interp1(x,g4,xd(rd),'linear');
id5 = interp1(x,g5,xd(rd),'linear');

[ie1,id1] =  sincronia(ie1,id1,20);
[ie2,id2] =  sincronia(ie2,id2,20);
[ie3,id3] =  sincronia(ie3,id3,20);
[ie4,id4] =  sincronia(ie4,id4,20);
[ie5,id5] =  sincronia(ie5,id5,20);

se1 = sum(ie1)*d;
se2 = sum(ie2)*d;
se3 = sum(ie3)*d;
se4 = sum(ie4)*d;
se5 = sum(ie5)*d;

sd1 = sum(id1)*d;
sd2 = sum(id2)*d;
sd3 = sum(id3)*d;
sd4 = sum(id4)*d;
sd5 = sum(id5)*d;

subplot(1,4,1);bar([se1 sd1; se2 sd2;se3 sd3; se4 sd4;se5 sd5]); axis tight;
subplot(1,4,1);legend('\Sigmaf(-t)','\Sigmaf(t)')
subplot(1,4,2);bar(abs([sum(ie1+fliplr(id1))*d; sum(ie2+fliplr(id2))*d; sum(ie3+fliplr(id3))*d; sum(ie4+fliplr(id4))*d; sum(ie5+fliplr(id5))*d])); axis tight;
subplot(1,4,2);legend('Diff = \Sigmaf(-t) + \Sigmaf(t)')
subplot(1,4,3);plot(x(ind),X',':ok',x(ind),XD',':.r',x(ind),XD2',':sb',x(ind),XD3',':+g',x(ind),XD4',':sm',x(ind),XD5',':*c'); axis tight;
subplot(1,4,3);legend('Sem derivada','d1','d2','d3','d4','d5'); title('Coeficientes')
subplot(1,4,4);bar([sum(abs(X-XD)); sum(abs(XD2-XD));sum(abs(XD3-XD2)); sum(abs(XD4-XD3)); sum(abs(XD5-XD4))]); axis tight;
subplot(1,4,4);legend('Diferenças Consecutivas');
% plot(g1,'.'); hold on
% boxplot

%
% subplot(1,2,1);bar([sum(g1) sum(g2) sum(g3) sum(g4) sum(g5)]);
%
% subplot(1,2,2);bar([sum(g1') sum(g2') sum(g3') sum(g4') sum(g5')]);