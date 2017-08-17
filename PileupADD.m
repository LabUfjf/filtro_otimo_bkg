function [y] = PileupADD(setup,test,F,N)


load ShapeFEtime
load fit1g

base = 128; % 8ns entre amostras de sinal
f = base/test.amostras;

t_amostragem = setup.janela/test.amostras;

[d,fn] = fixPeaktime(ShapeFEtime,0,[1:f:128]*t_amostragem);

xtime = ([1:f:128]*t_amostragem)+d;

k = find(ShapeFEtime(xtime) == max(ShapeFEtime(xtime)));
xtimem = xtime(k);

y= zeros(128,N);


for i = 1:N
    j=0;
    
    time=timeGen(0,F,1);
    
    while ~isempty(time)
        j = j+1;
        yevt(:,j) = (fit1g.b1+(fit1g.c1/2)*randn(1,1))*ShapeFEtime(xtime+time-xtimem)/fn;
%         yevt(:,j) = (fit1g.b1+(fit1g.c1/2)*randn(1,1))*ShapeFEtime(time-xtime)/fn;
        time=timeGen(time,F,1);
    end
    
    if j >1
        y(:,i) = sum(yevt');
        clear yevt
    elseif j==1 
        y(:,i)= yevt;
        clear yevt
    end
    
    if j ==0;
        y(:,i)= zeros(128,1);
    end
    
    % subplot(2,1,1); plot(xtime,ShapeFEtime(xtime),'-k'); hold on
    % subplot(2,1,1); plot(xtime,A(i)*ShapeFEtime(xtime+time(i)-xtimem)); hold on
    % subplot(2,1,2); plot(xtime,sum(y'),'-k');
    % pause
end

end