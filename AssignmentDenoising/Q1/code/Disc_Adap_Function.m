function out = Disc_Adap_Function(x,gamma)
%DISC_ADAPTIVE_FUNCTION 
u = abs(x);
out = gamma*u - gamma^2 * log(1+u/gamma);
end

