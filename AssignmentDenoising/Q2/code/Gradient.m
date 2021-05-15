function [grad] = Gradient(X,Y,alpha,gamma, MRF)
    %GRADIENT 
    %  X : Predicted Noiseless Image 
    %  Y : Noisy Image
    
    if MRF == "Huber"
        grad = Rician_Grad(X,Y,alpha) - alpha*Huber_Grad(X,gamma);
        
    elseif MRF == "Quadratic"
        grad = Rician_Grad(X,Y,alpha) - alpha*Quadratic_Grad(X);
        
    elseif MRF == "Adaptive"
        grad = Rician_Grad(X,Y,alpha) - alpha*Adaptive_Grad(X,gamma);
     
    end
   
end

