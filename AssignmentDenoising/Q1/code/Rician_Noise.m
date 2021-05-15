function noise = Rician_Noise(xi,yi,alpha)
%RICIAN_NOISE Calculates the Rician Noise
noise = (1-alpha)*((xi^2 + yi^2)/2) - log(besseli(0, (1-alpha)*(xi*yi)));
end

