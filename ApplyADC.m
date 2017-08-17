function [SGADC,BGADC] = ApplyADC(SG,BG)

Bits  = 10;
Volts = 2;
SGADC = ApplyResolution(SG, Bits, Volts);
BGADC = ApplyResolution(BG, Bits, Volts);

end