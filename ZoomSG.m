function [sgzoom] = ZoomSG(signal,N)
im = find(signal==max(signal));
Ne = round((0.3)*N)-1;
Nd = round((0.7)*N);

ie = (im-Ne:im-1);
id = (im:im+Nd);

if N >= length(signal)
    i = 1:length(signal);
else
    if min(ie)<1 ie = 1:im-1; end
    if max(id)>length(signal) id = im:length(signal); end
    i= [ie id];
end
sgzoom = signal(i);
end