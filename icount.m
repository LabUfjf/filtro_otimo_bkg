function [i]=icount(test)
i1 = 0; i2 = 0; i3 = 0; i4 = 0; i5 = 0;

for T1 = test.amostras
    i1 = i1+1;
    for T2 = test.phase
        i2 = i2+1;
        for T3 = test.Pedestal
            i3 = i3+1;
            for T4 = test.NF
                i4 = i4+1;
                for T5 = test.bits
                    i5 = i5+1;
                end
            end
        end
    end
end


switch(test.variable)
    case 'amostras'
        i=i1;
    case 'phase'
        i=i2;
    case 'Pedestal'
        i=i3;
    case 'NF'
        i=i4;
    case 'bits'
        i=i5;
end

end