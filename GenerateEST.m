function [V] = GenerateEST(change,VAL,OF,C,A)

    for j = 1:length(C.A)
        OUT.A{j}=EST(VAL.ALL(:,OF.ind),C.order.A{j});
        D.A(j,:) = A'-OUT.A{j}';
    end
    
    D.A(j+1,:) = A-(VAL.SG(:,change.samples/2)')';
    V.A = mean(D.A');
    
end