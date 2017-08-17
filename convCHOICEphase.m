function [Nmax] = convCHOICEphase(SHAPE_VALID,SHAPE_ANALOG,sind,ordem)


[~,b]=sort(SHAPE_ANALOG,'descend');
sind=sort(b(1:ordem))';
Max_Shape_order = find(SHAPE_VALID(sind)==max(SHAPE_VALID(sind)));
Max_Shape = find(SHAPE_ANALOG==max(SHAPE_ANALOG));
Nmax = (Max_Shape-Max_Shape_order)+1;

