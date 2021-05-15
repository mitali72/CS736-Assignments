function noise = Gaussian_Noise(xi,yi,alpha)
%GAUSSIAN_NOISE Calculates the Gaussian Noise
noise = (1-alpha)*((yi-xi)^2);
end

