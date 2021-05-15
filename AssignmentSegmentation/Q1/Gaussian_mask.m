function h = Gaussian_mask(N,mu,sigma)
%GAUSSIAN_MASK Function to create a gaussian mask based on centre pixel
% N = filter size, mu = centre pixel intensity, sigma = spread

ind = -floor(N/2) : floor(N/2);
[X Y] = meshgrid(ind, ind);

% Create Gaussian with shifting by mu (intensity of centre pixel)
h = mu + exp(-(X.^2 + Y.^2) / (2*sigma*sigma));

% Normalize so that total area (sum of all weights) is 1
h = h / sum(h(:));

end

