function grad_matrix = Rician_Quad_Grad(trial_sol,noisy_image,alpha)
%RICIAN_QUAD_GRAD 

grad_matrix = arrayfun(@(x, y) Rician_Grad(x, y, alpha), trial_sol, noisy_image); 
quad_grad = Quadratic_Prior_Grad(trial_sol);
grad_matrix = grad_matrix + alpha*quad_grad;
        
end

