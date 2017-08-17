function [] = mao_program(INFO,filename,base,test,setup)

for i = 1:6
C(:,i) = INFO.CF{1}.A{i}{1};
end

OUT=INFO.OUT{1}.filter{1};
TRUTH=INFO.OUT{1}.truth;

DATA.OSC=INFO.data.v.sg+INFO.data.v.bg;
DATA.NDAQ=INFO.data.mod.v.NDAQ.all;

FPGATEST.FILTER.OUT=OUT;
FPGATEST.FILTER.CF=C;
FPGATEST.DATA.OSC=DATA.OSC;
FPGATEST.DATA.NDAQ=DATA.NDAQ;
FPGATEST.DATA.TRUTH=TRUTH;
FPGATEST.DATA.IND=INFO.sind{1};

save(filename,'FPGATEST','base','test','setup')
end