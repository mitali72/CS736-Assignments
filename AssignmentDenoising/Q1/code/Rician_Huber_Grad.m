function grad_matrix = Rician_Huber_Grad(trial_sol,noisy_image,alpha,gamma)
%RICIAN_HUBER_GRAD_NEW 

grad_matrix = arrayfun(@(x, y) Rician_Grad(x, y, alpha), trial_sol, noisy_image); 
huber_grad = Huber_Prior_Grad(trial_sol,gamma);
grad_matrix = grad_matrix + alpha*huber_grad;
        
end

