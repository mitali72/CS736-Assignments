function [X, objective] = Gradient_Descent(Y,alpha,gamma,MRF,plotit)
    %GRADIENT DESCENT 
    
    [rows,cols] = size(Y);
    s = 0.5*ones(rows,cols);
    X = Y;
    objective = zeros(1,100);
    
    for i = 1:150
       
        prevObj = Objective_Function(X,Y,alpha,gamma,MRF);
        grad = Gradient(X,Y,alpha,gamma,MRF);
     
        Xnew = X - grad.*s;
        
        newObj = Objective_Function(Xnew,Y,alpha,gamma,MRF); 
        check = (newObj< prevObj);
        X(check) = Xnew(check);
        s(check) = 1.1*s(check);
        s(~check) = 0.5*s(~check);
        
        if plotit == 1
           objective(1,i) = norm(prevObj);
        end 
    end
end

