function [g] = Coefciente_OF(ordem, NS, NC, no, nm, nf, s, SignalType, type)

g = cell(1,length(ordem)); % celula contendo as coordenadas dos shape do sinal


for i=1:length(ordem)
    clear g0 xd xu down up;
    if(SignalType==1) % desce do pico distribuido para ambos os lados
        g0 = [nm];  
    else             % pico ponto incial e final
        g0 = [no+1 nm nf];  
    end
       
    xd = no+2:nm-1;
    xu = nm+1:nf-1;
    down = no;
    
    Num = (1-(NS./ordem(i))).*ordem(i); % nº de pontos adicionais
    p3 = length(xd)/(NS-length(g0));
    p4 = length(xu)/(NS-length(g0));
    p5 = (floor(p3*NS)-1)+floor(Num/2); % nº de pontos antes do pico
    if(type==1) % Front-End
       p6 = (floor(p4*NS)-2)+round(Num/2); % nº de pontos depois do pico
    else        % Gaussiano
       p6 = (floor(p4*NS)-1)+round(Num/2); % nº de pontos depois do pico
    end
       
    if (p5<1)||(p6<1)||(p5+p6+length(g0)~=ordem(i))
        if(SignalType==1) % desce do pico distribuido para ambos os lados
            p5 =  round(p3*(ordem(i)-length(g0))); 
        else             % pico ponto incial e final
        	p5 =  floor(p3*(ordem(i)-length(g0)));  
        end       
        p6 = ordem(i)-length(g0)-p5;
    end
    
    if(SignalType==1) % desce do pico distribuido para ambos os lados
        down = [nm-1:-1:nm-p5]; 
        up   = [nm+1:1:nm+p6]; 
    else             % pico ponto incial e final
        for k=1:p5
            if(nm-k ~= no+1)
                down(k) = nm-k;  
            else
                down(k) = nm-k-2;  
            end              
        end
        for k=1:p6
            if(nm+k < nf)
                up(k) = nm+k;  
            else
                up(k) = nm+k+1;  
            end       
        end 
    end
        
    g{i} = sort([g0 down up]);
    
    if(ordem(i)>=NC)
       g{i} = [1:NC]; 
    end 
    
    if(g{i}(1)<1)
       g{i} = [1:ordem(i)]; 
    end 
    
end
clear p3 p4 p5 p6 down up go;



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % novo metodo selecionar pontos decrescendo do pico
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
if((SignalType==1)&&(type==0))
    for ii=1:length(ordem)       
        kup   = round((ordem(ii)-1)/2);
        kdown = ordem(ii)-1-kup;
        if(kdown>nm)
            kdown = nm-1;
            kup = ordem(ii)-1-kdown;
        end
        ndown = [nm-1:-1:nm-kdown];
        nup   = [nm+1:nm+kup];

        g{ii} = sort([ndown nm nup]);       
    end
end

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % novo metodo selecionar pontos decrescendo do pico
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
if((SignalType==1)&&(type==1))
    ndown = [nm-1:-1:1];
    nup   = [nm+1:NC];    
    
    aa = [fliplr(ndown) length(ndown):-(length(ndown)-1)/length(nup):1];
    s = s + aa;

    for ii=1:length(ordem)
        clear g0 kdown kup;

        g0 = [nm  zeros(1,ordem(ii)-1)];
        kdown = 1;
        kup   = 1;    

        for jj=1:ordem(ii)-1

            ONdown = 0;          
            if ((kdown<=length(ndown))&&(s(ndown(kdown))>s(nup(kup))))
                g0(jj+1) = ndown(kdown);
                ONdown = 1;        
            else
                g0(jj+1) = nup(kup);            
            end           
            if(ONdown==1)
                kdown = kdown + 1;
            else
                kup = kup + 1;
            end        
        end    
        g{ii} = sort(g0);
    end

end









