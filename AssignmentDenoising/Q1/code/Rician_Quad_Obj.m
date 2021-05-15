function penalty_matrix = Rician_Quad_Obj(trial_sol,noisy_image,alpha)
%RICIAN_QUAD_PIXEL_OBJ 

penalty_matrix = arrayfun(@(x, y) Rician_Noise(x, y, alpha), trial_sol, noisy_image);
quad_pen = Quadratic_Prior_Penalty(trial_sol);
penalty_matrix = penalty_matrix + alpha*quad_pen;
        
end

