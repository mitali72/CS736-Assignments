function grad = Rician_Grad(X,Y,alpha)
    %RICIAN_GRAD 
    %  gradient of negative log likelihood
    I1 = besseli(1,(1-alpha)*(X.*Y));
    I0 = besseli(0,(1-alpha)*(X.*Y));
    
    grad = (1-alpha)*X - ((1-alpha)*(I1./I0)).*Y;
end

