function [obj] = Objective_Function(X,Y,alpha,gamma,MRF)
    %OBJECTIVE FUNCTION 
    %   
    
    [rows,cols] = size(X);
    obj = zeros(rows,cols);
    
    likelihood = 0.5*(1-alpha)*(X.^2 + Y.^2) - log(besseli(0,(1-alpha)*(X.*Y)));
      
    if MRF == "Huber"
        obj = obj +  likelihood + alpha*Huber(X,gamma);
        
    elseif MRF == "Quadratic"
        obj = obj +  likelihood + alpha*Quadratic(X);
        
    elseif MRF == "Adaptive"
        obj = obj +  likelihood + alpha*Adaptive(X,gamma);
     
    end
    
end

