



zoom = (55:95);

for i =8:2:18
    figure(i)
subplot(1,2,1);stairs(zoom,INFO.data.tr.shape(zoom),':k'); hold on
SHAPEADC = ApplyResolution(INFO.data.tr.shape(zoom), i, 2);
subplot(1,2,1);stairs(zoom,0.996015936254980*SHAPEADC,':r'); axis tight
d=SHAPEADC-INFO.data.tr.shape(zoom);
subplot(1,2,2);bar(zoom,abs(d)); axis tight
pause
end