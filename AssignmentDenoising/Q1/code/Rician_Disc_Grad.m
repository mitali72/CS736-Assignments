function grad_matrix = Rician_Disc_Grad(trial_sol,noisy_image,alpha,gamma)
%RICIAN_DISC_GRAD 

grad_matrix = arrayfun(@(x, y) Rician_Grad(x, y, alpha), trial_sol, noisy_image); 
disc_grad = Disc_Adap_Prior_Grad(trial_sol,gamma);
grad_matrix = grad_matrix + alpha*disc_grad;

end

