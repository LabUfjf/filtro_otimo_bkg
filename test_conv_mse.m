clear; close all; clc
load data

DADO=data.v.sg;
FILTRO = data.v.shape(60:70);

td = size(DADO,1);
nd = size(DADO,2);
tf = size(FILTRO,1);
nt = td+tf;
nc=(td-tf+1);
DADOW =[DADO; 0*ones(tf,nd)];
FILTROW = [FILTRO; 0*ones(td,1)];

DADO2 =[DADO; NaN*ones(tf,nd)];
FILTRO2 = [FILTRO; NaN*ones(td,1)];

for s = 1:nc
MF(:,s) = circshift(FILTROW,s-1);
MFNaN(:,s) = circshift(FILTRO2,s-1);
end

for evt = 1:nd
MSENAN=(repmat(DADO2(:,evt),1,nc)-MFNaN).^2;
MSENAN(isnan(MSENAN))=0;
MSE(:,evt)=(1/tf)*sum(MSENAN);
[mi(evt)]=find(MSE(:,evt)==min(MSE(:,evt)));
end
CV = MF'*DADOW;
A = CV(mi,:);


% plot(CV(:,1:5),'-'); hold on
% plot(MSE(:,1:5),'-r')
% plot(mi(1:5),CV(mi(1:5),1:5),'o')
