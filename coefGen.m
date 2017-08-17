function [C] = coefGen (d)

no = length(d.da{1});
R = eye(no);
n = length(d.y);
D = [];
M = [];

for i = 1:n+1
    D = [D; d.da{i}];
    M{i} = [R D'
        D zeros(i,i)];
    if i == 1
        B.A{i} = [zeros(no,1) ;1];
        B.F{i} = [zeros(no,1) ;0];
        C.A{i} = linsolve(M{i},B.A{i});
        C.F{i} = linsolve(M{i},B.F{i});
    else
        B.A{i} = [zeros(no,1) ;1; zeros(i-1,1)];
        if i == 2
            B.F{i} = [zeros(no,1) ;0; -1];
        else
            B.F{i} = [zeros(no,1) ;0; -1; zeros(i-2,1)];
        end
        C.A{i} = linsolve(M{i},B.A{i});
        C.F{i} = linsolve(M{i},B.A{i});
    end
    C.A{i} = C.A{i}(1:no);
    C.F{i} = C.F{i}(1:no);
end


end