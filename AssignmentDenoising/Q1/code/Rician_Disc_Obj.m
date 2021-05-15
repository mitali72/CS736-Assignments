function penalty_matrix = Rician_Disc_Obj(trial_sol,noisy_image,alpha,gamma)
%RICIAN_DISC_OBJ 

penalty_matrix = arrayfun(@(x, y) Rician_Noise(x, y, alpha), trial_sol, noisy_image);
disc_pen = Disc_Adap_Prior_Penalty(trial_sol, gamma);
penalty_matrix = penalty_matrix + alpha*disc_pen;

end

