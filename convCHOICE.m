function [Nmax] = convCHOICE(data,SHAPE_VALID,SHAPE_ANALOG,sind,base)

nevt = length(data);
Max_Shape_order = find(SHAPE_VALID(sind)==max(SHAPE_VALID(sind)));
Max_Shape = find(SHAPE_ANALOG==max(SHAPE_ANALOG));
Nmax = (Max_Shape-Max_Shape_order)+1;

if base.uniform == 1
    Nmax = ones(nevt,1)*Nmax;
end