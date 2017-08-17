function [sgSIM,A] = SGSIM(shape,AP,N,g,doPlot)
bin = 100000;

if g == 1
    ci=55e-3;
    cs=160e-3;
else
    ci=15e-3;
    cs=200e-3;
end

[y,x]=hist(AP.A.value(AP.A.value>ci & AP.A.value<cs),bin);

if g == 1
     
    [fit1g] = fitA1gauss(x(y~=0), y(y~=0) ,doPlot);
    save fit1g fit1g 
      A=fit1g.b1+(fit1g.c1/2)*randn(N,1); A = A';
%     [A,~] = randfit(fit1g,N,[min(min(AP.datamax)) max(max(AP.datamax))],2000);
    
else
    [fit2g] = fit(x(y~=0)', y(y~=0)' ,'gauss2');
    
    if doPlot == 1
        figure
        plot(fit2g,x(y~=0), y(y~=0))
    end
    %     [fit2g] = fitA2gauss(x(y~=0), y(y~=0) ,doPlot);
    [A,~] = randfit(fit2g,N,[min(min(AP.A.value)) max(max(AP.A.value))],2000);
end

A=A(A>0);
% A = ApplyResolution(A, 4, 10);
% d=mean(A)-0.070588235294118;
% A=A-d;
for i = 1:length(A)
    % sgSIM(:,i) = A(i)*shape+bg(:,i);
    sgSIM(:,i) = A(i)*shape;
    %     plot(1:128,shape,'r',1:128,sgSIM,'-k');
    %     hold on
    %     pause
end


% for i = 1:1000;
% V=ApplyResolution(sgSIM(64,:), i, 2);
% M(i)=mean(V-A);
% end
% figure
% plot(M)
% pause


end