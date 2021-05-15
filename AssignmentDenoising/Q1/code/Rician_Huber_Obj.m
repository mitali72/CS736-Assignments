function penalty_matrix = Rician_Huber_Obj(trial_sol,noisy_image,alpha,gamma)
%RICIAN_HUBER_OBJ_NEW 

penalty_matrix = arrayfun(@(x, y) Rician_Noise(x, y, alpha), trial_sol, noisy_image);
huber_pen = Huber_Prior_Penalty(trial_sol, gamma);
penalty_matrix = penalty_matrix + alpha*huber_pen;

end

