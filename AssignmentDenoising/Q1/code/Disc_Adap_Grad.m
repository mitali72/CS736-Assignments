function grad = Disc_Adap_Grad(u,gamma)
%DISC_ADAP_GRAD 

grad = (u*gamma)/(gamma + abs(u));

end

