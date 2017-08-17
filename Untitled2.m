%% This code evaluates the gauss seidel method

% first, the user enters the tolerance value
tolerance=input('please enter the tolerance range for your results:  ');

n=input('please enter the number of equations to be evaluated: ');

sprintf('we then arrange the co efficients of the equations into a matrix \n') 
for i=1:1:n
    
    for j=1:1:n
        
        a(i,j)=input('please enter the next co-efficient of the equation:');
        
    end
    
    %here we also enter the right hand side value of the rquation
    b(i,1)=input('please enter the right hand side of that equation: ');
    
end


%%now we enter the initial guesses

for k=1:1:n
    c(k)=input('enter the initial guess: ');
    
end
sprintf('iteration number: \n')


%%produce errors of one hundred percent to get the simulation going
for m=1:1:n
    error(m,1)=100;
end
sprintf('this iteration number is: \n')
iteration=1

while (min(error)>=tolerance)
for m=1:1:n
    
%calculate first the terms to be subtracted from the right hand side value
for i=1:1:n
    
   value(i,1)=c(i)*a(m,i);

end
%now, subtract the first terms from the right hand side value
    value0=c(m)*a(m,m);

    preliminary=b(m,1)-(sum(value)-value0);
  x(m,1)= preliminary/a(m,m);


error(m,1)=abs(((x(m,1)-c(m))/x(m,1)))*100;
 c(m)=x(m,1);

end
sprintf('the values of x obtained from this iteration are: \n')
x
sprintf('the errors obtained from this iteration are')
error


iteration=iteration+1
 end