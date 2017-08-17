close all; clear variables; clc;
% OF TOY
format long
change.nf = 1;
change.phase = 0;
change.samples = 128;
change.order = 40;
change.bits = 10;
% for variance =5:1:50
[setup] = parameters(change.samples,20);
[base] = CovGen(setup,'ANALOG');

for var = linspace(-0.5,0.5,31)
    
    change.phase = var;
    disp(['PHASE=' num2str(var)])
    [TR,VAL,A] = GenerateData(setup,base,change);
    [OF,C] = GenerateCOEF(base,change,TR);
    [V] = GenerateEST(change,VAL,OF,C,A);
    %     M{i} = V.A;
    
    cor={'k';'r';'r';'m';'b';'b';'g'};
    mark={'*';'o';'+';'square';'o';'+';'v'};
    
    for k = 1:6+1
        figure(1)
        
        %  plot3(variance,change.phase,1e3*V.A(k),[':' mark{k} cor{k}]), hold on
        plot(change.phase,V.A(k)/setup.Aesc,[':' mark{k} cor{k}]), hold on
    end
    
    
end

% end
% figure(6);legend('NO RESTRICTION','PHASE','PHASE(2Diff)','PHASE(3Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)','PEDESTAL/PHASE(3Diff)','BASE', 'Location', 'Best');axis tight;
figure(1);legend('NO RESTRICTION','PHASE','PHASE(2Diff)','PEDESTAL','PEDESTAL/PHASE','PEDESTAL/PHASE(2Diff)', 'Location', 'Best');axis tight;