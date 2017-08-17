function [OF,C] = GenerateCOEF(base,change,TR)

    [OF] = SamplesChoice(base,TR,change);
    [C] = FilterCoef(change,OF);
    
end