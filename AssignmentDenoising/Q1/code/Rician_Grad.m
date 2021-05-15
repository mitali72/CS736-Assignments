function grad = Rician_Grad(xi,yi,alpha)
%RICIAN_GRADIENT 

grad = (1-alpha)*xi - (1-alpha)*yi*(besseli(1, (1-alpha)*(xi*yi))/besseli(0, (1-alpha)*(xi*yi)));

end

